
float angle;

void setup() {
  size(200, 200);
  angle=0;
}

void draw() {
  background(0);

  angle+=0.03;
  float xpos=900+cos(angle)*300;
  float ypos=500+sin(angle)*200;

  fill(255);
  //ellipse(xpos, ypos, 60, 60);
  
  surface.setLocation(int(xpos),int(ypos));
}
