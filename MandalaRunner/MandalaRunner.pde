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
boolean doCircles;

//color start = color(random(100, 255), random(100,255), random(100,255));
//color end = color(random(100,255), random(100,255), random(100,255));

color start = color(255, 15, 131);
color end = color(255, 208, 0);


//GUIs for controlling parameters
ControlP5 cp5;
Slider outerArchSlider;
Slider innerArchSlider;
Slider outerRadiusSlider;
Slider innerRadiusSlider;
Slider petalSlider;
Slider distanceSlider;
CheckBox checkbox;


boolean flag = true;
//float radius = 10;

void setup() {
  size(900, 900);
  background(0);
  centerX = width / 2;
  centerY = height / 2;
 
  // set initial variable values
  outerArches = 5;
  innerArches = 5;
  outerRadius = 200;
  innerRadius = 50;
  numPetals = 0;
  distance = 1;
  doFill = false;
  doLines = false;
  doCircles = false;
  
  //set parameter GUIs
  
  //set checkboxes 
  cp5 = new ControlP5(this);
  stroke(255);
  checkbox = cp5.addCheckBox("Boolean Effects")
                 .setPosition(750, 50)
                 .setSize(20, 20)
                 .addItem("Add Fill?", 0)
                 .addItem("Add Lines?", 0)
                 .addItem("Draw Circles?", 0)
                 .setSpacingRow(30);

  //set sliders
  outerRadiusSlider = cp5.addSlider("Outer Radius")
            .setPosition(50, 50)
            .setSize(200, 20) // Width and height of the slider
            .setRange(-360, 360) // Minimum and maximum values
            .setValue(outerRadius); // Initial value 
  
  innerRadiusSlider = cp5.addSlider("Inner Radius")
            .setPosition(50, 80)
            .setSize(200, 20) // Width and height of the slider
            .setRange(-360, 360) // Minimum and maximum values
            .setValue(innerRadius); // Initial value

  petalSlider = cp5.addSlider("Number of Petals")
            .setPosition(50, 150)
            .setSize(200, 20) // Width and height of the slider
            .setRange(0, 50) // Minimum and maximum values
            .setValue(numPetals) // Initial value
            .setNumberOfTickMarks(51)
            .showTickMarks(false)
            .setSliderMode(Slider.FIX);  

  distanceSlider = cp5.addSlider("Distance Factor")
            .setPosition(50, 350)
            .setSize(200, 20) // Width and height of the slider
            .setRange(-4, 4) // Minimum and maximum values
            .setValue(distance); // Initial value

  outerArchSlider = cp5.addSlider("Number of Outer Arches")
            .setPosition(50, 200)
            .setSize(200, 20) // Width and height of the slider
            .setRange(0, 50) // Minimum and maximum values
            .setValue(outerArches) // Initial value
            .setNumberOfTickMarks(51)
            .showTickMarks(false)
            .setSliderMode(Slider.FIX);

  innerArchSlider = cp5.addSlider("Number of Inner Arches")
            .setPosition(50, 250)
            .setSize(200, 20) // Width and height of the slider
            .setRange(0, 50) // Minimum and maximum values
            .setValue(innerArches) // Initial value
            .setNumberOfTickMarks(51)
            .showTickMarks(false)
            .setSliderMode(Slider.FIX);
}

void draw() {

    background(0);
    noFill();
    //displaySliders();
    //println("VALUE IS", outerRadius, "AND SLIDER VAL IS", outerRadiusSlider.sliderVal);

    
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
    doCircles   //drawCircle (boolean)
    );
    moveSpeed+=0.001;
    
    
    // Reset translation for GUI elements
    resetMatrix();
    cp5.draw();
    
}


void controlEvent(ControlEvent event) {
  // Check if the event is from the checkbox
  if (event.isFrom(checkbox)) {
    println("Checkbox state changed: " + checkbox.getState(0));
    // Toggle booleans according to user input on checkboxes
    doFill = checkbox.getItem(0).getBooleanValue();
    doLines = checkbox.getItem(1).getBooleanValue();
    doCircles = checkbox.getItem(2).getBooleanValue();
    
  }
}
