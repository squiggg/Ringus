ArrayList<PShape> rings = new ArrayList<PShape>();
float INNER_RAD = 2, OUTER_RAD = 9, INC = 2, STAR_COUNT = 5000, INC_INC = .5, RING_COUNT = 50, MIN_STAR_SIZE = 1, MAX_STAR_SIZE = 3;

void setup() {
  size(1600,1000,P3D);
  blendMode(ADD);
  for (int ringIndex = 0; ringIndex < RING_COUNT; ringIndex++) {
    PShape ring = createShape();
    ring.beginShape(POINTS);
    for (int starIndex = 0; starIndex < STAR_COUNT; starIndex++) {
      float a = random(0, 1) * TWO_PI;
      float r = sqrt(random(sq(INNER_RAD), sq(OUTER_RAD)));
      stroke(lerpColor(color(157, 47, 77), color(73, 115, 161), ringIndex/RING_COUNT));
      strokeWeight(random(MIN_STAR_SIZE, MAX_STAR_SIZE));
      ring.vertex(r * cos(a), r * sin(a), random(-INC, INC));
    }
    ring.endShape();
    rings.add(ring);
    INNER_RAD += INC;
    OUTER_RAD += INC * INC_INC;
    INC += INC_INC;
  }
}

void draw() { 
  background(0);
  camera(width/2, height/2, (height/2.0) / tan(PI * 30 / 180), 0, 0, 0, 0, 1, 0);
  for (int index = 0; index < RING_COUNT; index++) {
    pushMatrix();
    rotateY((TWO_PI/(index)*frameCount)/10);
    rotateX((TWO_PI/(index)*frameCount)/100);
    shape(rings.get(index));
    popMatrix();
  }
}

void keyPressed() {
  if (key == ' ') {
    frameCount = 0;
  }
}
