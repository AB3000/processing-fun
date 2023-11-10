void drawCircles(int depth, int radius, int amount){
  if(depth == 0){
    return;
  }
  
  fill(color(255, 0, 0), 90);
  circle(centerX, centerY - amount, radius);
  
  fill(color(255, 0, 102), 90);
  circle(centerX + amount/1.5, centerY - amount/1.5, radius);

  fill(color(255, 94, 0), 90);
  circle(centerX + amount, centerY, radius);
  
  fill(color(255, 145, 0), 90);
  circle(centerX + amount/1.5, centerY + amount/1.5, radius);
  
  fill(color(255, 196, 0), 90);
  circle(centerX, centerY + amount, radius);
  
  fill(color(255, 145, 0), 90);
  circle(centerX - amount/1.5, centerY + amount/1.5, radius);
  
  fill(color(255, 94, 0), 90);
  circle(centerX - amount, centerY, radius);
  
  fill(color(255, 0, 102), 90);
  circle(centerX - amount/1.5, centerY - amount/1.5, radius);

 
  drawCircles(depth-1, radius/2, amount-10);
  
}
