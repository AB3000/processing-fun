//float rotationAngle = 0;
color c;

void setup() {
  size(800, 800);
  noStroke();
  c = color(random(255), random(255), random(255));
  
}

void draw() {
  background(0);

  float centerX = width / 2;
  float centerY = height / 2;
  float initialRadius = 100;
  
  stroke(10);
  
  //if(frameCount % 2 == 0){
  //  // This code executes ever 2 frames.
  //}
  for(int i = 0 ; i < 6; i++){
    drawCircles(centerX, centerY, initialRadius, 10, 45 * i, c);
  }
  
}

void drawCircles(float x, float y, float radius, int depth, float angle, color c) {
  if (depth == 0){
    return;
  }
  
  fill(c);
  ellipse(x, y, radius, radius);
  
  float nextAngle = angle + 50;
  float nextRadius = radius * 0.75;
  
  drawCircles(x + radius * cos(angle), y + radius * sin(angle), nextRadius, depth-1, nextAngle, c);
  
}
