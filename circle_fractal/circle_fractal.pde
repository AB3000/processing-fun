ArrayList<Float[]> ellipseData = new ArrayList<>();
ArrayList<Integer> colors = new ArrayList<>();
//ArrayList<Boolean> colorsUsed;

int ellipseIndex = 0;
int framesPerEllipse = 1; // Adjust the frames per ellipse as needed
int circleAmount = 5;

// center of the canvas
float centerX;
float centerY;

// places where small color palette lines are drawn 
float topY; 
float bottomY; 

// amount that color palette lines move along the y-axis per frame
float moveAmount;

// start and end colors of fractal gradient
color startColor;
color endColor;

float firstFractalAngle = PI/2;
float secondFractalAngle = PI/2;
float initialAngle = secondFractalAngle;

float subAmt = 1;

void setup() {
  size(450, 800);
  background(0);
  noStroke();

  // center position of the screen
  centerX = width/2;
  centerY = height/2;

  // Regenerate new colors
  colorArray(circleAmount, colors, startColor, endColor);
  
  // set coordinates and move amount for color palette lines
  topY = centerY - height/4;
  bottomY = centerY + height/4;
  moveAmount = 0.01;
  
  // draw preset "sunset" colored fractal
  //drawCircles(6, 200, 100);
  
  
  fill(startColor, 100);
  translate(centerX, centerY);
  drawFractal(circleAmount, firstFractalAngle, 100, 0, 0);
  drawFractal(circleAmount, secondFractalAngle, -100, 0, 0);
  
  //drawFractal(5, PI*2, -200, 0, 0);
}

void draw() { 
  
    // clear the background on each frame
    background(0);

  // draw the color palette lines on each frame 
  // so they won't be lost / cleared
  drawColorPalette(colors, topY, bottomY);
  
    // always draw fractal at center of screen
    translate(centerX, centerY);
    
    // left fractal
    drawFractal(circleAmount, firstFractalAngle, 100, 0, 0); 
    // right fractal
    drawFractal(circleAmount, firstFractalAngle, -100, 0, 0);
    
    // rotate fractal (in radians) by a small amount each frame
    firstFractalAngle += moveAmount;

    // check if the fractal has traveled half a circle
    if((abs(firstFractalAngle - initialAngle) >= 3*PI/2 && moveAmount > 0)
    || (firstFractalAngle - initialAngle <= -PI/2 && moveAmount < 0)){
      // Regenerate new colors 
      colorArray(circleAmount, colors, startColor, endColor);
      // start moving fractal in the opposite direction
      moveAmount = -moveAmount;
    }
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

 void colorArray(int numColors, 
 ArrayList<Integer> colors, 
 color startColor,
 color endColor){
  // generates a random startColor and endColor
  startColor = color(random(100, 255), random(100, 255), random(100, 255));
  endColor = color(random(100, 255), random(100, 255), random(100, 255));
  
  // generates a gradient of colors from "startColor" to 
  // "endColor" to the array passed in, in-place
  colors.clear();
  colors.add(startColor);
  populateColors(circleAmount, colors, startColor, endColor);
  colors.add(endColor);
   
 }

 void populateColors(int numColors, 
 ArrayList<Integer> colors, 
 color startColor, 
 color endColor){
  
   // stop the recursive generation when max colors have been reached
   if(numColors == 0){
     return;
   }
   
   // generate a new color that takes an "average" / halfway color of the two colors passed in 
   color generatedLerpColor = lerpColor(startColor, endColor, 0.5);
   colors.add(generatedLerpColor);
   
   populateColors(numColors - 1, colors, startColor, generatedLerpColor);
   populateColors(numColors - 1, colors, generatedLerpColor, endColor);
}

void drawInnerCircles(int depth, float angle, float radius, boolean negativeAngle, int reached){
  if(depth == 0){
    return;
  }
  
    if(negativeAngle){
      circle((radius+depth) * cos(-angle), (radius-depth) * sin(-angle), radius);
    } else{
      circle((radius-depth) * cos(angle), (radius+depth) * sin(angle), radius);
    }
  
  drawInnerCircles(depth - 1, angle, radius/2, negativeAngle, reached+1);
}

void drawFractal(int depth, float angle, int radius, int colorIndex, int reached){
  
  if(depth == 0){
    return;
  }
  
  fill(colors.get(colorIndex), 100);
  
  if (reached > 1){
    fill(colors.get(colorIndex + 1), 120);
    drawInnerCircles(8, angle, radius, true, 0);
    
    fill(colors.get(colors.size() - 2 - colorIndex), 120);
    drawInnerCircles(8, angle, radius, false, 0);
  }
  

  drawFractal(depth-1, angle/2, radius, colorIndex + 1, reached+1);
  
}
