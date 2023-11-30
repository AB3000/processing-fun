void drawOuterArch() {
  float x1 = 365;
  float y1 = 334;
  float x2 = 347;
  float y2 = 244;
  float x3 = 411;
  float y3 = 277;
  float x4 = 416;
  float y4 = 208;
  
  // Calculate midpoint of the shape
  float midX = (x1 + x2 + x3 + x4) / 4.0;
  float midY = (y1 + y2 + y3 + y4) / 4.0;
  
  // Translation values to move the shape to the center of the canvas
  float translateX = width / 2 - midX;
  float translateY = height / 2 - midY;
  
  
  // Adjust coordinates based on translation
  x1 += translateX;
  y1 += translateY;
  x2 += translateX;
  y2 += translateY;
  x3 += translateX;
  y3 += translateY;
  x4 += translateX;
  y4 += translateY;
  
  //filter( BLUR, 1 );
  // Drawing the Bezier curve at the center of the canvas
  bezier(x1, y1, x2, y2, x3, y3, x4, y4);
  translate(65, 0);
  bezier(width - x1, y1, width - x2, y2, width - x3, y3, width - x4, y4);
  rotate(1);
  bezier(width - x1, y1, x2, y2, x3, y3, x4, height - y4);

}


void drawPetals(){
  
}
