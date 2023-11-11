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

/**
 * Generates a random startColor and endColor, then populates an ArrayList with a gradient of colors from
 * "startColor" to "endColor" using recursive color interpolation. The resulting colors are stored
 * in "colors", with the startColor at the beginning and the endColor at the end.
 *
 * @param numColors   The number of colors in the gradient, excluding 
 *                    startColor and endColor.
 * @param colors      The ArrayList to store the generated colors.
 * @param startColor  The initial color of the gradient.
 * @param endColor    The final color of the gradient.
 */
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
  populateColors(numColors, colors, startColor, endColor);
   
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
   if(numColors == 0){
     // add the last color
     colors.add(endColor);
     return;
   }
  
   // generate a new color that takes an "average" / 
   // halfway color of the two colors passed in 
   color generatedLerpColor = lerpColor(startColor, endColor, 0.5);
   colors.add(generatedLerpColor);
   
   // generate the half-way color of the first half 
   populateColors(numColors - 1, colors, startColor, generatedLerpColor);
   // generate the half-way color of the second half 
   populateColors(numColors - 1, colors, generatedLerpColor, endColor);
}

/**
 * Recursively draws concentric circles at different radii
 * based on the following parameters.
 *
 * @param depth          The recursion depth, determining the number of 
 *                       concentric circles to draw.
 * @param angle          The angle at which the circles are drawn.
 * @param radius         The initial radius of the outermost circles.
 * @param negativeAngle  Indicates whether the circles are drawn in the 
 *                       negative angle direction.
 */
void drawInnerCircles(int depth, float angle, float radius, boolean negativeAngle){
  
    // base case, inner most circle reached
    if(depth == 0){
      return;
    }
  
    // draws inner circles recursively on either side depending on the value
    // of negativeAngle
    if(negativeAngle){
      circle((radius+depth) * cos(-angle), (radius-depth) * sin(-angle), radius);
    } else{
      circle((radius-depth) * cos(angle), (radius+depth) * sin(angle), radius);
    }
  
  drawInnerCircles(depth - 1, angle, radius/2, negativeAngle);
}

/**
 * Recursively draws a fractal pattern composed of concentric circles at different radii, with each layer
 * having a distinct color. The depth of recursion determines the number of outer-circles in the fractal.
 *
 * @param depth       The recursion depth, determining the number of concentric circle layers in the fractal.
 * @param angle       The angle at which the circles are drawn.
 * @param radius      The initial radius of the outermost circle in the current layer.
 * @param colorIndex  The index of the color in the gradient used for the current layer.
 * @param reached     The number of times the recursion has reached this point.
 */
void drawFractal(int depth, float angle, int radius, int colorIndex, int reached){
  
  // base case, circle at last angle drawn
  if(depth == 0){
    return;
  }
  
  // prevents an extra overlapping circle from being drawn
  if (reached > 1){
    
    // draw all the inner circles for both "halfway" points 
    // drawn at the current interation
    fill(colors.get(colorIndex + 1), 120);
    drawInnerCircles(8, angle, radius, true);
    
    fill(colors.get(colors.size() - 2 - colorIndex), 120);
    drawInnerCircles(8, angle, radius, false);
  }
  
  // draw the next outer circle 
  drawFractal(depth-1, angle/2, radius, colorIndex + 1, reached+1);
  
}
