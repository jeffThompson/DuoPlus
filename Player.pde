
class Player {
  float dia = 30;
  PVector pos;
  color f;

  Player(float x, float y, color _f) {
    pos = new PVector(x, y);
    f = _f;
  }

  void display() {
    fill(f);
    noStroke();
    ellipse(pos.x, pos.y, dia, dia);
  }
}