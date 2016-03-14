
class Enemy {
  float dia =      10;
  float maxSpeed = 1.5;
  int timeNew =    1 * 1000;
  
  PVector pos, speed;
  boolean isNew = true;
  long timeGenerated;
  float ringDia = dia + 10;
  float ringTrans = 50;
  

  Enemy (float x, float y) {
    pos = new PVector(x, y);
    speed = new PVector(random(-maxSpeed,maxSpeed), random(-maxSpeed,maxSpeed));
    timeGenerated = millis();
  }

  void update() {
    pos.add(speed);
    if (pos.x < dia/2 || pos.x > width-dia/2) speed.x *= -1;
    if (pos.y < dia/2 || pos.y > height-dia/2) speed.y *= -1;
  }

  void grow() {
    dia += 0.01;
  }

  void display() {
    if (isNew) {
      fill(255,0,0, ringTrans);
      noStroke();
      ellipse(pos.x, pos.y, ringDia, ringDia);
      ringDia += 1;
      ringTrans -= 1;
      if (timeGenerated + timeNew < millis()) isNew = false;
    }
    fill(200, 100, 0);
    noStroke();
    ellipse(pos.x, pos.y, dia, dia);
  }
}