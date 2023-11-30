

void drawTest(float cenX, 
float cenY, 
float innerRadius, 
float outerRadius,
int numArches,
float offset){
  
  rotate(offset);
  float angleBetween = 360f/numArches;
  float calculatedAngle = 90 - angleBetween/2f;
  
  float x1 = -cos(calculatedAngle*PI/180)*innerRadius;
  float y1 = -sin(calculatedAngle*PI/180)*innerRadius;
  

  //float x2 = x1 + 18;
  //float y2 = y1 - 90;
  
  
  float x4 = 0;
  float y4 = -outerRadius;
  
  float x2 = x1;
  float y2 = (y4 + y1) / 2;
  
  //float x3 = x4 - 5;
  //float y3 = y4 + 69;
  
  float x3 = x4;
  float y3 = (y4 + y1) / 2;
  
  for (int i = 0; i < numArches; i++){
    bezier(x1, y1, x2, y2, x3, y3, x4, y4);
    bezier(-x1, y1, -x2, y2, -x3, y3, -x4, y4);
    //line(-x1, y1, -x2, y2);
    //line(-x1, y1, -x3, y3);
    //line(-x1, y1, -x4, y4);
    //line(x1, y1, x2, y2);
    //line(x1, y1, x3, y3);
    //line(x1, y1, x4, y4);
    rotate(angleBetween*PI/180);
  }

  
}
