color c;
ArrayList<Float[]> ellipseData = new ArrayList<>();
int ellipseIndex = 0;
int framesPerEllipse = 5; // Adjust the frames per ellipse as needed

void setup() {
  size(800, 800);
  noStroke();
  c = color(random(255), random(255), random(255));
  
  background(0);

  float centerX = width / 2;
  float centerY = height / 2;
  float initialRadius = 100;
  
  stroke(10);
  // This code executes ever 2 frames.
  for(int i = 0 ; i < 6; i++){
    drawCircles(centerX, centerY, initialRadius, 10, 45 * i, c);
  }
  
  frameRate(30);
}

void draw() {
  //if (frameCount % 2 == 0){
    //for(int i = 0; i < ellipseData.size(); i++){
    //  ellipse(ellipseData.get(i)[0], 
    //  ellipseData.get(i)[1], 
    //  ellipseData.get(i)[2], 
    //  ellipseData.get(i)[2]);
    //}
  //}
  
    // Draw one ellipse at a time with a delay
  if (ellipseIndex < ellipseData.size() && frameCount % framesPerEllipse == 0) {
    Float[] currentEllipse = ellipseData.get(ellipseIndex);
    ellipse(currentEllipse[0], currentEllipse[1], currentEllipse[2], currentEllipse[2]);
    ellipseIndex++;
  }

}

void drawCircles(float x, float y, float radius, int depth, float angle, color c) {
  if (depth == 0){
    return;
  }
  
  fill(c);
  //ellipse(x, y, radius, radius);
  ellipseData.add(new Float[]{x, y, radius});
  
  float nextAngle = angle + 50;
  float nextRadius = radius * 0.75;
  drawCircles(x + radius * cos(angle), y + radius * sin(angle), nextRadius, depth-1, nextAngle, c);
  
}
