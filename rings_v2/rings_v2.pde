ArrayList<PShape> rings = new ArrayList<PShape>();
float INNER_RAD = 1, OUTER_RAD = 9, INC = 2, STAR_COUNT = 5000, INC_INC = .5, RING_COUNT = 50;

void setup() {
  size(1600, 900, P3D);
  blendMode(ADD);
  for (int ringIndex = 0; ringIndex < RING_COUNT; ringIndex++) {
    PShape ring = createShape();
    ring.beginShape(POINTS);
    for (int starIndex = 0; starIndex < STAR_COUNT; starIndex++) {
      float a = random(0, 1) * TWO_PI;
      float r = sqrt(random(sq(INNER_RAD), sq(OUTER_RAD)));
      stroke(lerpColor(color(157, 47, 77), color(73, 115, 161), ringIndex/RING_COUNT));
      strokeWeight(random(1, 3));
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
    rotateX((TWO_PI)*frameCount/100000);
    shape(rings.get(index));
  }
}

void keyPressed() {
  if (key == ' ') {
    frameCount = 0;
  }
}
