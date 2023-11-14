color c = color(random(255), random(255), random(255));
ArrayList<Float[]> ellipseData = new ArrayList<>();
ArrayList<Integer[]> colors = new ArrayList<>();
int ellipseIndex = 0;
int framesPerEllipse = 1; // Adjust the frames per ellipse as needed
int moveSize = 5;

void setup() {
  size(450, 800);
  noStroke();
  
  background(0);

  float centerX = width / 2;
  float centerY = height / 2;
  float initialRadius = 70;
  
  //stroke(10);
  // This code executes ever 2 frames.
  for(int i = 0 ; i < 6; i++){
    //c = color(random(255), random(255), random(255));
    drawCircles(centerX, centerY, initialRadius, 10, 45 * i, 255, c);
  }
  
  frameRate(60);
}

void draw() {  
  // Draw one ellipse at a time with a delay
  if (ellipseIndex < ellipseData.size() && frameCount % framesPerEllipse == 0) {
    Float[] currentEllipse = ellipseData.get(ellipseIndex);
    fill(colors.get(ellipseIndex)[0],  colors.get(ellipseIndex)[1]);
    ellipse(currentEllipse[0], currentEllipse[1], currentEllipse[2], currentEllipse[2]);
    ellipseIndex++;
  }
  
  //if(ellipseIndex == ellipseData.size()){
  //  for(int i = 0; i < ellipseData.size(); i++){
  //    Float[] currentEllipse = ellipseData.get(i);
  //    currentEllipse[2] /= 1.25;
  //    ellipse(currentEllipse[0] + moveSize, currentEllipse[1] + moveSize, currentEllipse[2], currentEllipse[2]);
  //  }
  //}
  
  //moveSize-=5;
 
}

void drawCircles(float x, float y, float radius, int depth, float angle, int alpha, color c) {
  if (depth == 0){
    return;
  }
  
  //ellipse(x, y, radius, radius);
  ellipseData.add(new Float[]{x, y, radius});
  colors.add(new Integer[]{c, alpha});
  
  float nextAngle = angle + 50;
  float nextRadius = radius * 0.75;
  drawCircles(x + radius * cos(angle), y + radius * sin(angle), nextRadius, depth-1, nextAngle, alpha - 20, c + 30);
  
}
