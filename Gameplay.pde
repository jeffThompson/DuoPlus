
void gameplay() {
  // enemies
  for (Enemy e : enemies) {
    e.update();
    e.grow();
    e.display();    

    // die?
    if (circleCircle(r.pos.x, r.pos.y, r.dia/2, e.pos.x, e.pos.y, e.dia/2) ||
      circleCircle(l.pos.x, l.pos.y, l.dia/2, e.pos.x, e.pos.y, e.dia/2)) {
      score = int(millis()-startTime)/1000.0;
      if (score > highScore) {
        highScore = score;
        newHighScore = true;
      }
      String[] updatedScores = (String[])append(scores, str(score));
      saveStrings("HighScores.txt", updatedScores);
      died = true;
    }
  }

  // time passed? new enemies
  if (lastGeneratedTime + generateInterval < millis()) {
    float x = random(20, width-20);
    float y = random(20, height-20);
    while (x >= width/2-20 && x <= width/2+20 && 
      dist(x, y, r.pos.x, r.pos.y) < r.dia*2 &&
      dist(x, y, l.pos.x, l.pos.y) < l.dia*2) {
      x = random(20, width-20);
    }
    Enemy n = new Enemy(x, y);
    enemies.add(n);
    lastGeneratedTime = millis();
  }

  // player
  r.pos.x = constrain(mouseX, width/2+r.dia/2+divOffset, width-r.dia/2);
  r.pos.y = constrain(mouseY, r.dia/2, height-r.dia/2);
  r.display();

  l.pos.x = map(r.pos.x, width/2+r.dia/2+divOffset, width-r.dia/2, width/2-r.dia/2-divOffset, r.dia/2);
  l.pos.y = r.pos.y;
  l.display();

  // middle divider
  if (divIncrease) {
    noStroke();
    fill(220);
    rect(width/2-divOffset,0,divOffset*2,height);
    divOffset += divSpeed;
    if (divOffset > divOffsetMax) divOffset = divOffsetMax;
  } else {
    stroke(100);
    strokeWeight(3);
    line(width/2, 0, width/2, height);
  }

  // score
  fill(0);
  noStroke();
  score = int(millis()-startTime)/1000.0;
  textFont(font, 24);
  textAlign(LEFT, TOP);
  text(nf(score, 0, 2) + " SEC", 20, 20);
}