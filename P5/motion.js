// used to prevent performance degradation
let MAX_POINTS = 2000;


// line angle information
let bigAngle, midAngle;
let bigAngleSlider, midAngleSlider, lineSizeSlider;

//changeable visual attributes
let strokeSize;
let lineColor;

// layer for trail that moving arms make
let lineSize = 0;
let pg;
let points = [];


function setup(){

  // STARTING VALUES for angle 
  bigAngle = PI;
  midAngle = PI;
  lineSize = 75;
  createCanvas(350, 350).parent('canvasContainer');
  pg = createGraphics(350, 350).parent('canvasContainer');

  // create ANGLE sliders

  // min val, max val, starting val, increment val 
  bigAngleSlider = createSlider(0, 0.1, 0, 0.001);
  midAngleSlider = createSlider(0, 1, 0, 0.1);
  lineSizeSlider = createSlider(10, 100, 75, 1);

  // crate & display big line slider
  bigAngleValueDisplay = createDiv('Big Line Speed: ' + bigAngleSlider.value().toFixed(3));
  bigAngleValueDisplay.parent('controlPanel');
  bigAngleValueDisplay.style('color', 'white');
  bigAngleValueDisplay.style('margin', '10px');
  bigAngleSlider.parent('controlPanel');
  bigAngleSlider.style('margin', '0px');

  // crate & display mid line slider
  midAngleValueDisplay = createDiv('Mid Line Speed: ' + midAngleSlider.value().toFixed(1));
  midAngleValueDisplay.parent('controlPanel');
  midAngleValueDisplay.style('color', 'white');
  midAngleValueDisplay.style('margin', '10px');
  midAngleSlider.parent('controlPanel');
  midAngleSlider.style('margin', '0px');

  lineSizeValueDisplay = createDiv('Line Size: ' + lineSizeSlider.value().toFixed(1));
  lineSizeValueDisplay.parent('controlPanel');
  lineSizeValueDisplay.style('color', 'white');
  lineSizeValueDisplay.style('margin', '10px');
  lineSizeSlider.parent('controlPanel');
  lineSizeSlider.style('margin', '0px');


  // Label for the color picker
  let colorPickerLabel = createDiv('Choose Line Color:');
  colorPickerLabel.parent('controlPanel');
  colorPickerLabel.style('color', 'white');
  

  // Color picker setup
  colorPicker = createColorPicker('#ff0000');
  colorPicker.parent('controlPanel');
  colorPicker.style('margin', '10px');


  // button to reset drawing  
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
  lineSize = lineSizeSlider.value();

  // draw center Circle 


  line(0, 0, lineSize*cos(bigAngle), lineSize*sin(bigAngle));
  
  // draw mid-size line
  translate(lineSize*cos(bigAngle), lineSize*sin(bigAngle));
  line(0, 0, (lineSize/2)*cos(midAngle), (lineSize/2)*sin(midAngle));

  // draw "point" circle at big line and midsizeLine
  fill(0, 255, 0);
  noStroke();
  circle(0, 0, 5); //big line circle 
  circle((lineSize/2)*cos(midAngle), (lineSize/2)*sin(midAngle), 3);

  
    // Limit the number of points stored
    if (points.length > MAX_POINTS) {
        points.shift(); // Remove the oldest point if over the limit
    }

    points.push({
        x: width / 2 + lineSize * cos(bigAngle) + (lineSize / 2) * cos(midAngle),
        y: height / 2 + lineSize * sin(bigAngle) + (lineSize / 2) * sin(midAngle),
        color: colorPicker.value() // Store the current color picker value with the point
    });
  
  
  
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
    pg.clear();
    pg.colorMode(RGB, 255);
    pg.strokeWeight(2); // Adjust as needed for the thickness of the line

    // Iterate over the points array to draw each segment with its stored color and glow
    for (let i = 0; i < points.length - 1; i++) {
        let start = points[i];
        let end = points[i + 1];

        // Parse the stored color string to a p5 Color
        let segmentColor = start.color; // Assuming this is stored in a format that p5 can parse directly
        pg.stroke(segmentColor);

        // Apply glow effect based on the segment's color
        // Adjusting shadowBlur for desired glow intensity
        pg.drawingContext.shadowBlur = 20; // Example intensity
        pg.drawingContext.shadowColor = segmentColor;

        // Draw the segment from start to end
        pg.line(start.x, start.y, end.x, end.y);
    }

    image(pg, 0, 0);
}