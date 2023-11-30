int numSpikes = 5; // Number of spikes
float[] spikeX, spikeY; // Arrays to store spike coordinates

void userInput() {
  if (numSpikes < 3) {
    println("Please enter a number greater than or equal to 3.");
    userInput();
  } else {
    spikeX = new float[numSpikes];
    spikeY = new float[numSpikes];
    redraw();
  }
}

void drawMandala() {
  float angle = TWO_PI / numSpikes;
  float radius = 3;

  for (int i = 0; i < numSpikes; i++) {
    spikeX[i] = radius * cos(angle * i);
    spikeY[i] = radius * sin(angle * i);
  }

  stroke(30);
  strokeWeight(2);
  fill(200);

  beginShape();
  for (int i = 0; i < numSpikes; i++) {
    //vertex(spikeX[i], spikeY[i]);
    rect(spikeX[i], spikeY[i], 20, 20);
  }
  endShape(CLOSE);
}
