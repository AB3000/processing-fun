


void drawCircleFractal(){
  
    // clear the background on each frame
    background(0);
    displayParameters();

    // draw the color palette lines on each frame 
    // so they won't be lost / cleared
    drawColorPalette(colors, topY, bottomY);
  
    // always draw fractal at center of screen
    translate(centerX, centerY);
    
    // left fractal
    drawFractal(circleAmount, fractalAngle, radius, 0, 0, innerDepth); 
    // right fractal
    drawFractal(circleAmount, fractalAngle, -radius, 0, 0, innerDepth);
    
    // rotate fractal (in radians) by a small amount each frame
    fractalAngle += moveAmount;
        
    // check if the fractal has traveled half a circle
    if((abs(fractalAngle - initialAngle) >= (initialAngle + PI) && moveAmount > 0)
    || (fractalAngle - initialAngle <= (initialAngle - PI) && moveAmount < 0)
    || (moveAmount == 0 && frameCount % rateFrames == 0)){
      
      if(doCircleChange){
        circleAmount += circleChange;
      } 
     
      if(doDepthChange){
        innerDepth += depthChange;
      }
      
      // Regenerate new colors 
      colorArray(circleAmount, colors, startColor, endColor);
      // start moving fractal in the opposite direction
      moveAmount = -moveAmount;
    }
    
    if(doRadiusChange){
      radius += radiusChange;
    } 
    
    if(doLayerSpacingChange){
      layerSpacing += layerSpacingChange;
    } 
    
    handleParameterChanges();
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
void drawInnerCircles(int depth, float angle, float radius, boolean negativeAngle, int colorIndex){
  
    // base case, inner most circle reached
    if(depth == 0){
      return;
    }

    // draws inner circles recursively on either side depending on the value
    // of negativeAngle
    if(negativeAngle){
      fill(colors.get(colorIndex), 120);
      circle((radius+depth) * cos(-angle), (radius-depth) * sin(-angle), radius);
    } else{
      fill(colors.get(colors.size() - 1 - colorIndex), 120);   
      circle((radius-depth) * cos(angle), (radius+depth) * sin(angle), radius);
    }
  
  drawInnerCircles(depth - 1, angle, radius/layerSpacing, negativeAngle, colorIndex);
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
void drawFractal(int depth, float angle, float radius, int colorIndex, int reached, int innerDepth){
  
  // base case, circle at last angle drawn
  if(depth == 0){
    return;
  }
  
  // prevents the extra circles from being drawn
  if (reached >= circleHideAmount){
    // draw all the inner circles for both "halfway" points 
    // drawn at the current interation
    drawInnerCircles(innerDepth, angle, radius, true, colorIndex);
    drawInnerCircles(innerDepth, angle, radius, false, colorIndex);
  }
  
  // draw the next outer circle 
  drawFractal(depth-1, angle/2, radius, colorIndex + 1, reached+1, innerDepth);
  
}
