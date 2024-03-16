let bigAngle = 0;
let bigAngleSlider, midAngleSlider;
let lineSize = 0;
let pg;
let points = []; // Array to store points positions


function setup(){
  bigAngle = PI;
  midAngle = PI;
  lineSize = 75;
  createCanvas(350, 350).parent('canvasContainer');
  pg = createGraphics(350, 350).parent('canvasContainer');

  // create sliders
  bigAngleSlider = createSlider(0, 0.1, 0.01, 0.001);
  midAngleSlider = createSlider(0, 1, 0.1, 0.1);

  // display big line slider
  bigAngleValueDisplay = createDiv('Big Line Speed: ' + bigAngleSlider.value().toFixed(3));
  bigAngleValueDisplay.parent('controlPanel');
  bigAngleValueDisplay.style('color', 'white');
  bigAngleValueDisplay.style('margin', '10px');

  bigAngleSlider.parent('controlPanel');
  bigAngleSlider.style('margin', '0px');

  // display mid line slider
  midAngleValueDisplay = createDiv('Mid Line Speed: ' + midAngleSlider.value().toFixed(1));
  midAngleValueDisplay.parent('controlPanel');
  midAngleValueDisplay.style('color', 'white');
  midAngleValueDisplay.style('margin', '10px');

  midAngleSlider.parent('controlPanel');
  midAngleSlider.style('margin', '0px');

  // reset the drawing 
  let resetButton = createButton('Reset Canvas');
  resetButton.parent('controlPanel'); // Assuming you have a div with an ID of 'controlPanel'
  resetButton.style('display', 'block'); // Ensures the button appears on its own line
  resetButton.style('margin', '10px auto'); // Centers the button and adds margin
  resetButton.mousePressed(resetCanvas); // Specifies what function to call
  
}


function draw() {
  background(0); // Clear the canvas with a black background
  bigAngleValueDisplay.html('Big Line Speed: ' + bigAngleSlider.value().toFixed(3));
  midAngleValueDisplay.html('Mid Line Speed: ' + midAngleSlider.value().toFixed(1));
  
  // Draw the persistent points on the main canvas
  drawPersistentPoints();

  // Translate and draw motion without affecting the points the line draws
  translate(width / 2, height / 2);
  
  drawMotion();
}

function drawMotion() {
  // draw big base line 
  strokeWeight(1);
  stroke(255);
  line(0, 0, lineSize*cos(bigAngle), lineSize*sin(bigAngle));
  ellipse(lineSize*cos(bigAngle), lineSize*sin(bigAngle), 5, 5); 
  
  // draw mid-size line
  translate(lineSize*cos(bigAngle), lineSize*sin(bigAngle));
  line(0, 0, (lineSize/2)*cos(midAngle), (lineSize/2)*sin(midAngle));
  
  // push points / trail that are drawn into an array 
  points.push({x: width/2 + lineSize*cos(bigAngle) + (lineSize/2)*cos(midAngle), 
               y: height/2 + lineSize*sin(bigAngle) + (lineSize/2)*sin(midAngle)});
  
  
  // change angles so lines move along a "spiral-circular" path
  bigAngle+= bigAngleSlider.value();
  midAngle += midAngleSlider.value();
}


function resetCanvas() {
    points = []; // Clears the array of points
    pg.clear(); // Clears the pg buffer, removing all drawn points/lines
    // If needed, reinitialize any variables that determine the drawing state
    bigAngle = PI;
    midAngle = PI;
}

function drawPersistentPoints() {
    // Clear the pg buffer to start fresh each frame
    pg.clear();
  
    pg.colorMode(RGB, 255);
    
    // Configure the glow effect for pg
    pg.drawingContext.shadowBlur = 25; // Adjust the glow's blur radius
    pg.drawingContext.shadowColor = color(0, 255, 255); // Set a bright color for the glow effect
  
    // Use a bright, fully opaque color for the stroke
    pg.stroke(0, 255, 255);
    pg.strokeWeight(2); // Set the stroke weight for better visibility
  
    pg.noFill();
    pg.beginShape();
  
    for (let point of points) {
      // Draw the line with vertices at the points' locations
      pg.vertex(point.x, point.y);
    }
  
    pg.endShape();
  
    // No need to reset shadowBlur since we're clearing each frame
    // Draw the pg layer which includes the glowing line
    image(pg, 0, 0);
  }
  

// function drawPersistentPoints() {
//     pg.colorMode(HSB, 360, 100, 100, 100); // Set color mode for pg

//     // Configure glow effect for pg
//     pg.drawingContext.shadowBlur = 10; // Adjust the glow's blur radius
//     pg.drawingContext.shadowColor = pg.color(207, 7, 99, 100); // Set glow color and opacity

//     pg.noStroke(); // No stroke for the circles
//     pg.fill(207, 7, 99, 100); // Set fill color; adjust as needed
    
//     for (let point of points) {
//       // Draw a small circle for each point to get a glow effect
//       pg.circle(point.x, point.y, 1); // Adjust size as needed
//     }
    
//     // Reset shadowBlur for pg to avoid affecting subsequent drawings
//     pg.drawingContext.shadowBlur = 0;
  
//     // Draw the entire pg layer which includes the glowing points
//     image(pg, 0, 0);
// }