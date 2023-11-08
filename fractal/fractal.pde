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
  drawCircles(centerX, centerY, initialRadius, 5, 45, c);
}

void drawCircles(float x, float y, float radius, int depth, float angle, color c) {
  if (depth == 0){
    return;
  }
  
  fill(c);
  ellipse(x, y, radius, radius);
  
  //float endX = x + radius * cos(angle);
  //float endY = y + radius * sin(angle);
  for(int i = 0; i < 5; i++){
    // Increase the radius and angle for the next segment of the spiral
    float nextRadius = radius * 0.5;
    float nextAngle = angle + 50;
    drawCircles(x + radius * cos(angle), y + radius * sin(angle), nextRadius, depth-1, nextAngle, c);
  }
  
  
  
}

void drawSpiral(float x, float y, float radius, float angle, int depth) {
  if (depth == 0) {
    return;  // Stop the recursion
  }

  float endX = x + radius * cos(angle);
  float endY = y + radius * sin(angle);

  line(x, y, endX, endY);

  // Increase the radius and angle for the next segment of the spiral
  float nextRadius = radius * 0.5;
  float nextAngle = angle + 50;

  // Recursive call for the next segment
  //for(int i = 0; i < 5; i++){
    drawSpiral(endX, endY, nextRadius, nextAngle, depth - 1);
  //}
  
}
