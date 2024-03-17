// used to prevent performance degradation
let MAX_POINTS = 2000;

// line angle information
let bigAngle, midAngle;
let bigAngleSlider, midAngleSlider, lineSizeSlider;

// changeable visual attributes
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


  // SETUP FOR ALL THE CONTROLLABLE PARAMETERS 
  // create ANGLE sliders
  // min val, max val, starting val, increment val 
  bigAngleSlider = createSlider(0, 0.1, 0.037, 0.001);
  midAngleSlider = createSlider(0, 1, 0.1, 0.1);
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
  resetButton.parent('controlPanel'); 
  resetButton.style('display', 'block'); 
  resetButton.style('margin', '10px auto'); 
  resetButton.mousePressed(resetCanvas);
  
}


function draw() {
  background(0); // Clear the canvas with a black background
  bigAngleValueDisplay.html('Big Line Speed: ' + bigAngleSlider.value().toFixed(3));
  midAngleValueDisplay.html('Mid Line Speed: ' + midAngleSlider.value().toFixed(1));
  
  // Draw the persistent points on the main canvas
  if(bigAngleSlider.value() != 0 || midAngleSlider.value() != 0){
    drawPersistentPoints();
  }

  // Translate and draw motion without affecting the points the line draws
  translate(width / 2, height / 2);
  
  drawMotion();
}

function drawMotion() {
  // draw big base line 
  strokeWeight(1);
  stroke(255);
  lineSize = lineSizeSlider.value();


  // draw big line
  line(0, 0, lineSize*cos(bigAngle), lineSize*sin(bigAngle));

  // draw center Circle 
  fill(colorPicker.value());
  circle(0, 0, 10);

  // draw mid-size line
  translate(lineSize*cos(bigAngle), lineSize*sin(bigAngle));
  line(0, 0, (lineSize/2)*cos(midAngle), (lineSize/2)*sin(midAngle));

  // draw "point" circle at big line and midSizeLine
  fill(0, 255, 0);
  //big line circle 
  circle(0, 0, 5); 
  //mid line circle 
  circle((lineSize/2)*cos(midAngle), (lineSize/2)*sin(midAngle), 3);


    // Limit the number of points stored to prevent performance degradation
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
    points = []; // Clear point array 
    pg.clear(); // Clear buffer / remove  all drawn points/lines

    // restart new drawing from original angle
    bigAngle = PI;
    midAngle = PI;
}

function drawPersistentPoints() {
    pg.clear();
    pg.colorMode(RGB, 255);
    pg.strokeWeight(2);

    // Iterate over the points array to draw each segment with its stored color and glow
    for (let i = 0; i < points.length - 1; i++) {
        let start = points[i];
        let end = points[i + 1];

        // Parse the stored color string to a p5 Color
        let segmentColor = start.color; // Assuming this is stored in a format that p5 can parse directly
        pg.stroke(segmentColor);

        // Apply glow effect based on the color of current segment 
        pg.drawingContext.shadowBlur = 20; // glow appears decently 
        pg.drawingContext.shadowColor = segmentColor;

        // Draw each segment 
        pg.line(start.x, start.y, end.x, end.y);
    }

    image(pg, 0, 0);
}