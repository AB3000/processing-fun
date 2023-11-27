ArrayList<Integer> colors = new ArrayList<>();

// number*4 of outer circles to draw
// excluding the first and last one
// the amount of hands displayed will be 4x this number
int circleAmount = 4;
// demonstrate number of circles change in real time
//radius boundaries to display, min and max
// along with rate of change 
int minCircleAmount = 2;
int maxCircleAmount = 5;
int circleChange = 1;
boolean doCircleChange = true;

// after when to start drawing circles
// 0 means no circles are hidden
int circleHideAmount = -1;

// number of inner circle layers to draw
int innerDepth = 10;
// demonstrate number of inner circles change in real time
//radius boundaries to display, min and max
// along with rate of change 
int minDepth = 1;
int maxDepth = 5;
int depthChange = 1;
boolean doDepthChange = true;

// amount that fractal rotates from the center per frame
float moveAmount = 0.02;
// little delta that speeds up the movement along the arc
// make value > 0 if you don't want a constant pace 
// fractal will move really quickly after a while if this number is big
// e.g.: try using 0.0005
float moveChange = 0;

// radius of outermost circle in fractal
float radius = 125;
// demonstrate radius change in real time
//radius boundaries to display, min and max
// along with rate of change 
float minRadius = 5;
float maxRadius = radius;
float radiusChange = 0.5;
boolean doRadiusChange = true;

// determines distance between outer and inner circles
// larger = more spaced out
float layerSpacing = 2;
// demonstate layer spacing in real time
//boundaries of the layer spacing, min and max
// along with rate of change 
float maxLayerSpacing = 5;
float minLayerSpacing = 0.9;
float layerSpacingChange = 0.01;
boolean doLayerSpacingChange = true;

// center of the canvas
float centerX;
float centerY;

// Values on y-axis where small color palette lines are drawn 
float topY; 
float bottomY; 

// start and end colors of fractal gradient
color startColor;
color endColor;
// if true, generate random start and end colors
// if false, choose colors from preset array
boolean useRandomColors = false;
// current index of the predefined color array, if passed in
int colorArrayIndex = 0;

// start angle of the fractal
float fractalAngle = PI/2;
float initialAngle = fractalAngle;

//frame rate of redrawing
int rateFrames = 60;

// used for frameRate change in doDemo() (the demo)
int changer = 7;

// which case to run? 
int whichFractal = 1;

// sunset fractal parameters 
// how many circles are drawn inside
float sunsetDepth = 6;

//the radius of the outermost circle 
float sunsetRadius = 200;
float sunsetRadiusChange = 1;
int sunsetMaxRadius = 200;

// the space between inner layers
float sunsetAmount = -100;
float sunsetAmountChange = 0.75;
int sunsetMaxAmount = 100;
int sunsetMinAmount = -100;


void setup() {
  size(450, 800);
  background(0);
  noStroke();
  
  frameRate(rateFrames);

  // center position of the screen
  centerX = width/2;
  centerY = height/2;

  // Generate colors for first frame
  if(useRandomColors){
    colorArray(circleAmount, colors);
  } else{
    colorArray(circleAmount, colors, sagittariusColors);
  }
  
  // set coordinates and move amount for color palette lines
  topY = centerY - height/5 - radius/2;
  bottomY = centerY + height/5 + radius/2;

}

void draw() {  
  
  switch(whichFractal) {
    case 0:
      // run the demo 
      doDemo();
      drawCircleFractal(null, null);
      break;
    case 1:
      // draw fractal with preset colors
      // useRandomColors is false? 
      // enter array of [{start, end}...] colors you want
      // along with a list of strings associated with each {start, end} object
      
      drawCircleFractal(sagittariusColors, sagittarius);
      drawSagittariusSymbol(150, 180);
      drawSagittariusSymbol(-150, 180);
      drawSagittariusSymbol(150, -180);
      drawSagittariusSymbol(-150, -180);
      break;
    case 2: 
      // useRandomColors is true? 
      // DO null, null if useRandomColors is true 
      // draw fractal with random colors
      drawCircleFractal(null, null);
      break;
    case 3: 
      // clear background on every frame to prevent continous draws on top of each other
      background(0);
      // draw preset "sunset" colored fractal
      //depth, radius, amount 
      sunsetChange();
      drawCircles(sunsetDepth, sunsetRadius, sunsetAmount);
      break;
  }
}

void doDemo(){
  
  // isolate "number of circles" change
  if(frameCount == rateFrames){
    // set all variables to false except first parameter
    doDepthChange = false;
    doLayerSpacingChange = false;
    // set moveAMount to 0 beecause this will be a parameter to change
    moveAmount = 0;
    circleAmount = 1;
    doCircleChange = true;
  }
  
  // isolate inner depth change  
  if(frameCount == rateFrames * changer * 2){
    innerDepth = 1;
    doCircleChange = false;
    doDepthChange = true;
  }
  
  // isolate radius size change 
  if(frameCount == rateFrames * changer * 3){
    radius = 130;
    doDepthChange = false;
    doRadiusChange = true;
  }
  
  // isolate layer spacing change 
  if(frameCount == rateFrames * changer * 4){
    layerSpacing = 2;
    doRadiusChange = false;
    doLayerSpacingChange = true;
  }
  
  // isolate movement change
  if(frameCount == rateFrames * changer * 5){
    doLayerSpacingChange = false;
    moveAmount = 0.01;
  }
  
  // start demo again
  if(frameCount == rateFrames * changer * 6){
    moveAmount = 0;
    frameCount = 0;
  }
  
}


void sunsetChange(){
  
  sunsetRadius -= sunsetRadiusChange;
  
  if(sunsetRadius < -sunsetMaxRadius || sunsetRadius > sunsetMaxRadius){
    sunsetRadiusChange = -sunsetRadiusChange;
  }
  
  sunsetAmount -= sunsetAmountChange;
  
  if(sunsetAmount < sunsetMinAmount || sunsetAmount > sunsetMaxAmount){
    sunsetAmountChange = -sunsetAmountChange;
  }
  
}

void handleParameterChanges(){
  
  // move amount
  if(abs(moveAmount) > 0){
    if (moveChange < 0) {
      moveAmount-=moveChange;
    } else {
      moveAmount+=moveChange;
    }
  }

  // number of circles in outer later change
  if (doCircleChange && (circleAmount >= maxCircleAmount || circleAmount <= minCircleAmount)) {
      // bind the parameter so its within the specified range
     if (circleAmount >= maxCircleAmount){
       circleAmount = maxCircleAmount;
       circleChange = -abs(circleChange);
     }
      if (circleAmount <= minCircleAmount){
       circleAmount = minCircleAmount;
       circleChange = abs(circleChange);
     }
  }
  
  // radius of outermost circle 
  if(doRadiusChange && (radius >= maxRadius || radius <= minRadius)){; 
      if (radius >= maxRadius){
        radius = maxRadius;
        radiusChange = -abs(radiusChange);
      }
      if (radius <= minRadius){
        radius = minRadius;
        radiusChange = abs(radiusChange);
      }
  }
  
  if(doLayerSpacingChange && (layerSpacing >= maxLayerSpacing || layerSpacing <= minLayerSpacing)){
       layerSpacingChange = -layerSpacingChange; 
      if (layerSpacing >= maxLayerSpacing){
        layerSpacing = maxLayerSpacing;
        layerSpacingChange = -abs(layerSpacingChange);
      }
      if (radius <= minRadius){
        layerSpacing = minLayerSpacing;
        layerSpacingChange = abs(layerSpacingChange);
      }
  }
  
  if(doDepthChange && (innerDepth >= maxDepth || innerDepth <= minDepth)){
    // bind the parameter so its within the specified range
     if (innerDepth >= maxDepth){
       innerDepth = maxDepth;
       depthChange = -abs(depthChange);
     }
      if (innerDepth <= minDepth){
       innerDepth = minDepth;
       depthChange = abs(depthChange);
     }
  }
}


void displayParameters(String[] colorMeanings){
  // display parameters 
  textSize(17);
  color regular = color(230, 255, 255); 
  color changedParameter = color(0, 408, 612);
  fill(regular);
  
  // arrange parameters 
  float baseHeightPlace = topY - height/6;
  float startingPoint = 2.5;
  float spacer = 0.5;
  
  
  textAlign(LEFT);
  
  fill(abs(moveAmount) > 0 ? changedParameter: regular);
  text("Angle(rad): " + nf(fractalAngle, 0, 4), centerX - width/2.5, startingPoint*baseHeightPlace); 
  startingPoint+=spacer;
  
  fill(doCircleChange ? changedParameter : regular);
  text("Total Circles per Layer: " + circleAmount*4, centerX - width/2.5, startingPoint*(baseHeightPlace)); 
  startingPoint+=spacer;
  
  fill(doDepthChange ? changedParameter : regular);
  text("Inner Depth: " + innerDepth, centerX - width/2.5, startingPoint*(baseHeightPlace)); 
  
  //reset starting point
  startingPoint-=spacer*2;
  
  textAlign(RIGHT);
  
  fill(abs(moveAmount) > 0 ? changedParameter: regular);
  text("Move Amount: ", centerX + width/2.5 - width/10, startingPoint*baseHeightPlace); 
  text(moveAmount, centerX + width/2.5, startingPoint*baseHeightPlace); 
  startingPoint+=spacer;
  
  fill(doRadiusChange ? changedParameter : regular);
  text("Outer Radius: ", centerX + width/2.5 - width/10, startingPoint*baseHeightPlace); 
  //round to two decimal places for better readability
  text(nf(radius, 0, 2), centerX + width/2.5, startingPoint*baseHeightPlace); 
  startingPoint+=spacer;
  
  fill(doLayerSpacingChange ? changedParameter : regular);
  text("Layer Spacing: ", centerX + width/2.5 - width/10, startingPoint*baseHeightPlace);
  text(layerSpacing, centerX + width/2.5, startingPoint*baseHeightPlace); 
  
  startingPoint-=spacer*4;
  
  textAlign(CENTER);
  //display what the color represents on screen 
  if(colorMeanings != null){
    textSize(25);
    fill(startColor);
    //println("COLOR ARRAY INDEX IS ", colorArrayIndex);
    text(colorMeanings[colorArrayIndex-1], centerX, startingPoint*baseHeightPlace);
    textSize(17);
  }
  String starting = "(" + int(red(startColor))
  + ", " + int(green(startColor)) + ", "  + int(blue(startColor)) + ")";
  String ending = "(" + int(red(endColor))
  + ", " + int(green(endColor)) + ", "  + int(blue(endColor)) + ")";
  fill(startColor);
  text("Start Color: " + starting, centerX, bottomY + height/16);
  fill(endColor);
  text("End Color: " + ending, centerX, bottomY + 1.5*(height/14));
  
  
}

/**
 * Draws a color palette on the canvas with circles representing colors from the provided list.
 * Two lines of circles are drawn, one at topLineY and the other at bottomLineY.
 * The circles are evenly distributed horizontally based on the canvas width.
 *
 * @param colors       The list of colors to be represented in the color palette.
 * @param topLineY     The y-coordinate of the top line of circles in the color palette.
 * @param bottomLineY  The y-coordinate of the bottom line of circles in the color palette.
 */
 void drawColorPalette(ArrayList<Integer> colors, 
 float topLineY,
 float bottomLineY){
  for (int i = 0; i < colors.size(); i++) {
    fill(colors.get(i));
    
    // Calculate the x-coordinate based on the width of the canvas
    float x = map(i, 0, colors.size() - 1, 50, width - 50);
    
    // draw top and bottom color palette lines
    circle(x, topLineY, 10);
    circle(x, bottomLineY, 10);
  }
 }

/**
 * Generates a random startColor and endColor, then populates an ArrayList with a gradient of colors from
 * "startColor" to "endColor" using recursive color interpolation. The resulting colors are stored
 * in "colors", with the startColor at the beginning and the endColor at the end.
 *
 * @param numColors   The number of colors in the gradient, excluding 
 *                    startColor and endColor.
 * @param colors      The ArrayList to store the generated colors.
 */
 void colorArray(int numColors, 
 ArrayList<Integer> colors)
 {
   println("GENERATED A RANDOM START COLOR");
  // generates a random startColor and endColor
  // represents the first and last color of the gradient
  // declared globally at top
  startColor = color(random(100, 255), random(100, 255), random(100, 255));
  endColor = color(random(100, 255), random(100, 255), random(100, 255));
  // generates a gradient of colors from "startColor" to 
  // "endColor" to the array passed in, in-place
  colors.clear();
  populateColors(numColors, colors, startColor, endColor);
 }
 
 /**
 * Gets the next start and end color, then populates an ArrayList with a gradient of colors from
 * "startColor" to "endColor" using recursive color interpolation. The resulting colors are stored
 * in "colors", with the startColor at the beginning and the endColor at the end.
 *
 * @param numColors         The number of colors in the gradient, excluding 
 *                          startColor and endColor.
 * @param colors            The ArrayList to store the generated colors.
 * @param predefinedColors  The initial color of the gradient.
 */
 void colorArray(int numColors, 
 ArrayList<Integer> colors, 
 color[][] predefinedColors){
    
  // wrap back to the first index if at the end 
  if(colorArrayIndex >= predefinedColors.length){
    colorArrayIndex = 0;
  }
  // grabs next startColor and endColor
  startColor = predefinedColors[colorArrayIndex][0];
  endColor = predefinedColors[colorArrayIndex][1];
  colors.clear();
  populateColors(numColors, colors, startColor, endColor);
  
  // increment index so that next colors will show up on next cycle
  colorArrayIndex++;
 }

/**
 * Recursively populates an ArrayList with a gradient of colors between the given startColor and endColor.
 * The number of colors in the gradient is determined by the numColors parameter,
 * which corresponds to the number of outer circles in the fractal.
 *
 * @param numColors   The number of colors in the gradient, excluding startColor and endColor.
 * @param colors      The ArrayList to store the generated colors.
 * @param startColor  The initial color of the gradient.
 * @param endColor    The final color of the gradient.
 */

 void populateColors(int numColors, 
 ArrayList<Integer> colors, 
 color startColor, 
 color endColor){
  
   // add firstColor only at the start
   if(colors.isEmpty()){
     colors.add(startColor);
   }
   
   // stop the recursive generation when max colors have been reached
   if(numColors <= 0){
     // add the last color
     colors.add(endColor);
     return;
   }
  
   // generate a new color that takes an "average" / 
   // halfway color of the two colors passed in 
   color generatedLerpColor = lerpColor(startColor, endColor, 0.5);
   colors.add(generatedLerpColor);
   
   // generate the half-way color of the first half 
   populateColors(numColors - 2, colors, startColor, generatedLerpColor);
   // generate the half-way color of the second half 
   populateColors(numColors - 2, colors, generatedLerpColor, endColor);
}
