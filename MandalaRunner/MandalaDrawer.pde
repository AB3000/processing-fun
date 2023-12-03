void drawArchMandala(int numOuterArches, 
int numInnerArches, 
float baseOuterRadius,
float baseInnerRadius,
int numPetals,
float distanceFactor,
float speed,
boolean addFill,
boolean addLines,
boolean drawInnerCircle,
boolean drawOuterCircle){
   int totalArches = numOuterArches + numInnerArches + numPetals;
   
  //outer petal arches
  for(int i = numPetals; i > 2; i--){
      float amount = map(i, 0, totalArches - 1, 0.0, 1.0);
      drawArch(i*20, i*50, i, moveSpeed*i*0.5, 
      lerpColor(startColor, endColor, amount),
      addFill, false, drawInnerCircle, drawOuterCircle, 2);
  }
  
  for(int i = 0; i < numOuterArches; i++){
    float amount = map(i + numPetals, 0, totalArches - 1, 0.0, 1.0);
    drawArch(
    baseOuterRadius, baseInnerRadius-i*10, 10, speed, 
    lerpColor(startColor, endColor, amount), 
    addLines, addFill, drawInnerCircle, drawOuterCircle, 1);
  }
  
  for(int i = 0; i < numInnerArches; i++){
    float amount = map(i + numPetals + numOuterArches, 0, totalArches - 1, 0.0, 1.0);
    drawArch(
    (baseOuterRadius * distanceFactor)+(i*10), 
    baseInnerRadius, 
    10, speed, lerpColor(startColor, endColor, amount), 
    addFill, addLines, drawInnerCircle, drawOuterCircle, 1);
  }
  
}
