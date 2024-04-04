
float angle = 60; 

void setup() {
  //450, 800 for insta size
  size(960, 1000);
  frameRate(30);
  stroke(255);
  strokeWeight(3);
  colorMode(HSB, 360, 100, 100);
  
}

void draw() {
  background(0);
  
  //translate sketch to the center always 
  translate(width/2, height/2);
  
  // initial radius 
  float radius = 250;
  
  // draw 6 inner circles following a "rainbow" gradient 
  for(int i = 0; i < 7; i++){
    float hue = map(i, 0, 5, 0, 200);
    fill(hue, 100, 100, 180);
    drawCircles(radius, angle+i*2);
    radius /= 1.5;
  }
  angle += 0.25;
  
}


void drawCircles(float radius, float initialAngle){
  //draw 6 blades 
  for(int i = 1; i < 7; i++){
    float radianAngles = radians(initialAngle * i);
    line(0, 0, radius*cos(radianAngles), radius*sin(radianAngles));
    circle((radius + radius/4)*cos(radianAngles), (radius + radius/4)*sin(radianAngles), radius/2);
  }
}
