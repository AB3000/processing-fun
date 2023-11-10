color c = color(random(255), random(255), random(255));
ArrayList<Float[]> ellipseData = new ArrayList<>();
ArrayList<Integer> colors = new ArrayList<>();
int ellipseIndex = 0;
int framesPerEllipse = 1; // Adjust the frames per ellipse as needed
int circleAmount = 5;

float centerX = width/2;
float centerY = height/2;

void setup() {
  size(450, 800);
  background(0);
  noStroke();

  // center position of the screen
  centerX = width/2;
  centerY = height/2;
  
  // generate random colors as a gradient-start and gradient-end
  color startColor = color(random(100, 255), random(100, 255), random(100, 255));
  color endColor = color(random(100, 255), random(100, 255), random(100, 255));
  
  // generates a gradient of colors to the array passed in, in-place
  //colors.add(startColor);
  populateColors(circleAmount, colors, startColor, endColor);
  //colors.add(endColor);
  
  for(int i = 0; i < colors.size(); i++){
    println(colors.get(i));
    fill(colors.get(i));
    circle(20 + i*12, 200, 10);
  }
  
  // draw preset "sunset" colored fractal
  //drawCircles(6, 200, 100);
  
  
  fill(startColor, 100);
  translate(centerX, centerY);
  drawFractal(circleAmount, PI*2, 100, 0, 0);
  drawFractal(circleAmount, PI*2, -100, 0, 0);
  
  //drawFractal(5, PI*2, -200, 0, 0);
}

void draw() {  
 
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
  
  //if (reached != 0){
    if(negativeAngle){
      circle((radius+depth) * cos(-angle), (radius-depth) * sin(-angle), radius);
    } else{
      circle((radius-depth) * cos(angle), (radius+depth) * sin(angle), radius);
    }
  //}
  
  drawInnerCircles(depth - 1, angle, radius/2, negativeAngle, reached+1);
}

void drawFractal(int depth, float angle, int radius, int colorIndex, int reached){
  
  if(depth == 0){
    return;
  }
  
  fill(colors.get(colorIndex), 100);
  
  if (reached > 1){
    print("COLOR IS ", colors.get(colorIndex));
    fill(colors.get(colorIndex + 1), 120);
    drawInnerCircles(5, angle, radius, true, 0);
    //circle(radius/2 * cos(angle), radius/2 *sin(angle), radius);
    
    
    //fill(colors.get(colors.size() - 2 - colorIndex), 50);
    fill(colors.get(colors.size() - 2 - colorIndex), 120);
    drawInnerCircles(5, angle, radius, false, 0);
    //circle(radius/2 * cos(-angle), radius/2 *sin(-angle), radius);
  }
  

  drawFractal(depth-1, angle/2, radius, colorIndex + 1, reached+1);
  //drawFractal(depth-1, -angle/2, radius, recurseAmt + 1);
  
}
