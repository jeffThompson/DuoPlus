
void die() {
  background(200);

  // what is the game?
  textFont(font, 48);
  textAlign(CENTER, CENTER);
  fill(0);
  noStroke();
  text("DUO PLUS", width/2, height/2);

  // score
  textFont(scoreFont, 18);
  textAlign(CENTER, TOP);
  if (newHighScore) {
    text("NEW HIGH SCORE!\n" + highScore + " SEC", width/2, height/2+40);
  } else {
    text("YOUR SCORE\n" + score + " SEC\n\n" + "HIGH SCORE\n" + highScore + " SEC", width/2, height/2+40);
  }
  
  // restart
  if (millis() % 1000 < 500) {
    text("[ any key to restart ]", width/2, height/2+200);
  }
}