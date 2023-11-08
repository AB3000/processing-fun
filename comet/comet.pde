int cometX;
int cometY;
float tailLength = 100; // Length of the comet's tail
PVector[] tail; // Array to store tail positions
ArrayList<PVector[]> tails; // Array to store tail positions
ArrayList<Float[]> directions; //array to store comet directions

int movAmount;

int numComets = 1;


void setup() {
  size(800, 600);
  cometX = width / 2;
  cometY = height / 2;
  
  //tail = new PVector[int(tailLength)];
  //for (int i = 0; i < tail.length; i++) {
  //  tail[i] = new PVector(cometX, cometY);
  //}
  
  tails = new ArrayList<>();
  directions = new ArrayList<>();
  
  for(int i = 0; i < numComets; i++){
    tails.add(new PVector[int(tailLength)]);
    float cometX = random(width);
    float cometY = random(height);
    for(int j = 0; j < tails.get(i).length; j++){
      tails.get(i)[j] = new PVector(cometX, cometY);
      directions.add(new Float[]{0.5f, 0.5f});
    }
  }
 
  //xDirection = 0.5; 
  //yDirection = 0.5;
  
  movAmount = 5;
  frameRate(30);
}

void draw() {
  background(0); // Set background color to black
  noStroke();

  // Update the first position of the tail with the current comet position
  //tail[0] = new PVector(cometX, cometY);
  
  for(int i = 0; i < tails.size(); i++){
    tails.get(i)[0] = new PVector(tails.get(i)[0].x, tails.get(i)[0].y);
    drawComet(color(153, 51, 0), 40, 40, i, tails.get(i));
  }
  
  //for(int i = 0; i < tails.size(); i++){
  //  drawComet(color(153, 51, 0), 40, 40, tails.get(i)[0].x, tails.get(i)[0].y, tails.get(i));
  //}
  
}


void drawComet(color c, int cometSizeX, int cometSizeY, int idx, PVector[] tail){
  if (tail[0].x > width-cometSizeX || tail[0].x < cometSizeX) {
    directions.get(idx)[0] *= -1.25;
    //print("X DIRECTION IS", xDirection);
    //print("TAIL 0 X IS ", tail[0].x);
  }
  if (tail[0].y > height-cometSizeY || tail[0].y < cometSizeY) {
    directions.get(idx)[1] *= -1;
    print("Y DIRECTION IS", directions.get(idx)[1]);
    print("TAIL 0 X IS ", tail[0].y);
  }
  
  tail[0].x += movAmount * directions.get(idx)[0];
  tail[0].y += movAmount * directions.get(idx)[1];
  
   // Draw the comet's tail
  int alpha = 100;
  
  // Shift the tail positions
  for (int i = tail.length - 1; i > 0; i--) {
    tail[i] = tail[i - 1];
  }
  
  beginShape();
  for (int i = 0; i < tail.length; i++) {
    int sizeX = cometSizeX - i;
    int sizeY = cometSizeY - i;
    
    fill(c, alpha);
    if(cometSizeX - i < 0){
      sizeX = cometSizeX /(i+1);
      sizeY = cometSizeY /(i+1);
    }
    
    ellipse(tail[i].x, tail[i].y, sizeX, sizeY);
    alpha-=3;
  }
  endShape();

  // Draw the comet's head
  fill(c, 100);  
  ellipse(tail[0].x, tail[0].y, cometSizeX, cometSizeY);
  
}
