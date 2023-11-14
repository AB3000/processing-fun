/**
 * Draws a circle fractal with customizable parameters, including color, number of circles,
 * inner circle depth, rotation, etc. based on specified conditions.
 *
 * @param colorList        A 2D array representing the color palette for the fractal.
 *                         Each row corresponds to a color palette, and each column reprresents the 
 *                         RGB values for the startColor and endColor, respectively. 
 *                         Pass in 'null' to generate random colors.
 * @param colorMeanings    An array of strings describing the meanings of each color in the palette.
 * @see                    The parameters for doCircleChange, doDepthChange, and re-coloring occur when 
 *                         the fractal has passed a "half cycle". 
 * @see                    The parameters for moveAmount, radius, and layerSpacing happen on every frame.
 * The @see parameters are located at the top of FractalRunner! 
 */
void drawCircleFractal(color[][] colorList, String[] colorMeanings){
  
    // clear the background on each frame
    background(0);
    displayParameters(colorMeanings);

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
      
      if(colorList == null){
        // Regenerate new random colors 
        colorArray(circleAmount, colors);
      } else{
        // generate gradient scale of colors from the two endpoints
        // in the predefined list passed in
        colorArray(circleAmount, colors, colorList);
      }

      if(moveAmount != 0){
        // start moving fractal in the opposite direction
        moveAmount = -moveAmount;
      }
   
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
