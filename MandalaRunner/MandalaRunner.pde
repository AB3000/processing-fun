int numArcs = 5; // Change this variable based on user input
float centerX; //= width / 2;
float centerY;
float moveSpeed = 1;

boolean flag = true;
//float radius = 10;

void setup() {
  size(900, 900);
  background(0);
  noFill();
  centerX = width / 2;
  centerY = height / 2;
  
  //drawOuterArch();
}

void draw() {
  //drawMandala();
  
  //if(flag){
    background(0);
    stroke(255);
    float weight = 2;
    
    //drawOuterArch();
    //drawRubbish();
    
    
    translate(centerX, centerY);
    for(int i = 8; i > 3; i--){
      //float cenX, float cenY, float innerRadius, float outerRadius, int numArches
       drawTest(centerX, centerY, i*30, i*40, i, moveSpeed*i*10);
      //strokeWeight(weight);
     
      //weight/=1.2;
    }
    moveSpeed+=0.00001;
  //}
  
  flag = false;
  

}
