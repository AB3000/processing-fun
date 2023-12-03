import controlP5.*;
import javax.swing.*; 

int numArcs = 7; // Change this variable based on user input
float centerX; //= width / 2;
float centerY;
float moveSpeed = 1;


// controllable parameters
float outerArches;
float innerArches;
float outerRadius;
float innerRadius;
int numPetals;
float distance;
boolean doFill;
boolean addLines;
boolean doLines;
boolean doInnerCircles;
boolean doOuterCircles;
float controlPointOneX;
float controlPointOneY;
float controlPointTwoX;
float controlPointTwoY;


//color start = color(random(100, 255), random(100,255), random(100,255));
//color end = color(random(100,255), random(100,255), random(100,255));

color startColor = color(255, 15, 131);
color endColor = color(255, 208, 0);


//GUIs for controlling parameters
ControlP5 cp5;
Slider outerArchSlider;
Slider innerArchSlider;
Slider outerRadiusSlider;
Slider innerRadiusSlider;
Slider petalSlider;
Slider distanceSlider;
CheckBox checkboxRight;
CheckBox checkboxLeft;
ColorPicker startColorPicker;
ColorPicker endColorPicker;
Slider oneXSlider;
Slider oneYSlider;
Slider twoXSlider;
Slider twoYSlider;

int sliderSize = 200;


boolean flag = true;
//float radius = 10;

void setup() {
  size(900, 900);
  background(0);
  centerX = width / 2;
  centerY = height / 2;
  
  float leftAlign = centerX - width/2.15;
  float rightAlign = centerX + width/2.25 - sliderSize;
  
  float topAlign = centerY - height/2.25;
  float bottomAlign = centerY + height/2.25;
 
  // set initial variable values
  outerArches = 5;
  innerArches = 5;
  outerRadius = 200;
  innerRadius = 50;
  numPetals = 0;
  distance = 1;
  doFill = false;
  doLines = false;
  doInnerCircles = false;
  doOuterCircles = false;
  controlPointOneX = 1;
  controlPointOneY = 1;
  controlPointTwoX = 1;
  controlPointTwoY = 1;
  
  //set parameter GUIs
 
  
  //set checkboxes 
  cp5 = new ControlP5(this);
  stroke(255);
  checkboxLeft = cp5.addCheckBox("Boolean Effects")
                 .setPosition(leftAlign, height/2 - 90)
                 .setSize(20, 20)
                 .addItem("Draw Inner Circles?", 0)
                 .addItem("Draw Outer Circles?", 0)
                 .setSpacingRow(30);

  checkboxRight = cp5.addCheckBox("Boolean Effects 2")
                 .setPosition(width - 120, height/2 - 90)
                 .setSize(20, 20)
                 .addItem("Add Fill?", 0)
                 .addItem("Add Lines?", 0)
                 .setSpacingRow(30);
  //set sliders
  
  outerArchSlider = cp5.addSlider("# Outer Arches")
            .setPosition(leftAlign, topAlign)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(0, 50) // Minimum and maximum values
            .setValue(outerArches) // Initial value
            .setNumberOfTickMarks(51)
            .showTickMarks(false)
            .setSliderMode(Slider.FIX);

  innerArchSlider = cp5.addSlider("# Inner Arches")
            .setPosition(leftAlign, topAlign + 30)
            .setSize(200, 20) // Width and height of the slider
            .setRange(0, 50) // Minimum and maximum values
            .setValue(innerArches) // Initial value
            .setNumberOfTickMarks(51)
            .showTickMarks(false)
            .setSliderMode(Slider.FIX);

  petalSlider = cp5.addSlider("Number of Petals")
            .setPosition(leftAlign, topAlign + 60)
            .setSize(200, 20) // Width and height of the slider
            .setRange(2, 50) // Minimum and maximum values
            .setValue(numPetals) // Initial value
            .setNumberOfTickMarks(49)
            .showTickMarks(false)
            .setSliderMode(Slider.FIX);  
            
  outerRadiusSlider = cp5.addSlider("Outer Radius")
            .setPosition(rightAlign - 30, topAlign)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(-360, 360) // Minimum and maximum values
            .setValue(outerRadius); // Initial value 
  
  innerRadiusSlider = cp5.addSlider("Inner Radius")
            .setPosition(rightAlign - 30, topAlign + 30)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(-360, 360) // Minimum and maximum values
            .setValue(innerRadius); // Initial value

  distanceSlider = cp5.addSlider("Distance Factor")
            .setPosition(rightAlign - 30, topAlign + 60)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(-4, 4) // Minimum and maximum values
            .setValue(distance); // Initial value



  oneXSlider = cp5.addSlider("Control Point 1 X")
            .setPosition(leftAlign, 730)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(-4, 4) // Minimum and maximum values
            .setValue(controlPointOneX); // Initial value
            
  oneYSlider = cp5.addSlider("Control Point 1 Y")
            .setPosition(leftAlign, 750)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(-4, 4) // Minimum and maximum values
            .setValue(controlPointOneY); // Initial value

            
  startColorPicker = cp5.addColorPicker("Start Color")
                    .setPosition(leftAlign, 780)
                    .setSize(100, 100) // Width and height of the color picker
                    .setColorValue(startColor); // Initial color value (optional)
            
            
  twoXSlider = cp5.addSlider("Control Point 2 X")
            .setPosition(rightAlign - 50, 730)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(-4, 4) // Minimum and maximum values
            .setValue(controlPointTwoX); // Initial value
            
  twoYSlider = cp5.addSlider("Control Point 2 Y")
            .setPosition(rightAlign - 50, 750)
            .setSize(sliderSize, 20) // Width and height of the slider
            .setRange(-4, 4) // Minimum and maximum values
            .setValue(controlPointTwoY); // Initial value
            
  endColorPicker = cp5.addColorPicker("End Color")
                    .setPosition(600, 780)
                    .setSize(100, 100) // Width and height of the color picker
                    .setColorValue(endColor); // Initial color value (optional)
}


void draw() {

    background(0);
    noFill();

    startColor = startColorPicker.getColorValue();
    endColor = endColorPicker.getColorValue();
    
    translate(centerX, centerY);
    //drawArchMandala(6, 6, 100, 90, 5, 2, moveSpeed, false, false, true);
    drawArchMandala(
    (int) outerArchSlider.getValue(),    //numOuterArches (int)
    (int) innerArchSlider.getValue(),    //numInnerArches (int)
    outerRadiusSlider.getValue(),  //baseOuterRadius (float)
    innerRadiusSlider.getValue(),  //baseInnerRadius  (float)
    (int) petalSlider.getValue(),    //numPetals (int)
    distanceSlider.getValue(),    //distanceFactor (float) 
    moveSpeed, //speed (float)
    doFill, //addFill (boolean)
    doLines, //addLines (boolean)
    doInnerCircles,   //drawInnerCircle (boolean)
    doOuterCircles   //drawOuterCircle (boolean)
    );
    moveSpeed+=0.001;
    
    
    // Reset translation for GUI elements
    resetMatrix();
    cp5.draw();
    
}


void controlEvent(ControlEvent event) {
  // Check if the event is from any checkboxes
  if (event.isFrom(checkboxRight) || event.isFrom(checkboxLeft)) {
    // Toggle booleans according to user input on checkboxes
    doFill = checkboxRight.getItem(0).getBooleanValue();
    doLines = checkboxRight.getItem(1).getBooleanValue();
    doInnerCircles = checkboxLeft.getItem(0).getBooleanValue();
    doOuterCircles = checkboxLeft.getItem(1).getBooleanValue();
  }
}
