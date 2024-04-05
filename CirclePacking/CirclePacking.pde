ArrayList<Circle> circles;
Circle boundaryCircle;
float minRadius = 2;
float maxRadius = 100;
int totalCircles = 700;

Circle newCircle;
int createCircleAttempts = 500;
int attempts = 0;

int paletteIndex;

void setup() {
  background(0);
  size(800, 800);
  circles = new ArrayList<Circle>();
  
  // define the larger circle
  float boundaryRadius = width / 2 * 0.8;
  boundaryCircle = new Circle(width / 2, height / 2, boundaryRadius);
  
  // style for the large circle
  fill(0);
  strokeWeight(5);
  stroke(255, 255, 255);
  
  // draw the large circle once
  circle(boundaryCircle.x, boundaryCircle.y, boundaryCircle.radius * 2);
  
  // reset stroke weight to 0 for the rest of the circles
  strokeWeight(0);
  
  // choose a random palette for circle pack
  paletteIndex = (int)random(palettes.length);
}

void draw() {
  if (circles.size() < totalCircles) {
    if (newCircle == null || attempts >= createCircleAttempts) {
      // ensure the new circle starts within the boundary
      do {
        newCircle = new Circle(random(width), random(height), minRadius);
      } while (!isWithinBoundary(newCircle, boundaryCircle));
      
      attempts = 0; // reset attempts for the new circle
    }

    if (!doesCircleHaveACollision(newCircle)) {  
      growCircle(newCircle, boundaryCircle);
      if (newCircle != null) { // if it's still not null, draw it
        fill(newCircle.col); // default fill for small circles
        circle(newCircle.x, newCircle.y, newCircle.radius * 2);
        //ADDED
        for(int i = 0; i < 3; i++){
          circle(newCircle.x, newCircle.y, (newCircle.radius * 2) / ((i + 1)* 1.25));
        }
      }
    } else {
      // finished growing the circle or failed to place it
      newCircle = null; // reset the current circle so we create a new one next frame
    }
  } else {
    noLoop(); // stop the drawing loop once we reach the desired number of circles
  }
  
  attempts++;
}

void growCircle(Circle circle, Circle boundary) {
  circle.radius++;
  if (!isWithinBoundary(circle, boundary) || doesCircleHaveACollision(circle)) {
    circle.radius--; // shrink back to the last valid size
    circles.add(circle); // add the circle to the list
    newCircle = null; // reset so we start a new one next frame
  }
}

boolean isWithinBoundary(Circle inner, Circle boundary) {
  float distanceFromCenter = dist(inner.x, inner.y, boundary.x, boundary.y) + inner.radius;
  return distanceFromCenter <= boundary.radius;
}

boolean doesCircleHaveACollision(Circle circle) {
  for (Circle other : circles) {
    float dx = circle.x - other.x;
    float dy = circle.y - other.y;
    float distance = sqrt(dx * dx + dy * dy);

    if (distance < circle.radius + other.radius) {
      return true; // collision detected
    }
  }
  return false; // no collision
}

class Circle {
  float x, y;
  float radius;
  color col;

  Circle(float x_, float y_, float radius_) {
    x = x_;
    y = y_;
    radius = radius_;
    // random color from palette
    col = palettes[0][(int)(random(palettes[paletteIndex].length))];
  }
}
