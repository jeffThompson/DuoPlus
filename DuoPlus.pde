
/*
DUO PLUS
Jeff Thompson | 2016 | www.jeffreythompson.org

Double-action for GPP16.

TO DO:
+ high res font?
+ set screen size to height but square

*/


int generateInterval = 2 * 1000;    // new enemies every N ms
boolean divIncrease =  false;       // increase divider size?
float divSpeed =       0.01;        // increase divider width by N px/frame
boolean died =         true;        // start on dead screen

Player l, r;
ArrayList<Enemy> enemies;
int numEnemies;
long startTime;
int lives;
long lastGeneratedTime;
float highScore;
boolean newHighScore;
String[] scores;
PFont font, scoreFont;
float score;
float divOffset, divOffsetMax;


void setup() {
  size(800, 800);
  noCursor();

  // generate player
  lives = 5;
  float startX = width/4;
  float startY = height/2;
  l = new Player(width/2-startX, startY, color(130, 150, 255));
  r = new Player(width/2+startX, startY, color(0, 165, 40));

  // generate enemies
  numEnemies = 2;
  enemies = new ArrayList<Enemy>();
  enemies.clear();
  for (int i=0; i<numEnemies; i++) {
    float x = random(20, width-20);
    float y = random(20, height-20);
    while (x >= width/2-20 && x <= width/2+20 &&
      dist(x, y, r.pos.x, r.pos.y) < r.dia*2 &&
      dist(x, y, l.pos.x, l.pos.y) < l.dia*2) {
      x = random(20, width-20);
    }
    Enemy e = new Enemy(x, y);
    enemies.add(e);
  }
  lastGeneratedTime = millis();

  // score
  startTime = millis();
  font = loadFont("Avenir-Roman-48.vlw");
  scoreFont = loadFont("Avenir-Roman-18.vlw");
  newHighScore = false;
  scores = loadStrings("HighScores.txt");
  highScore = 0.0;
  for (String score : scores) {
    float s = Float.parseFloat(score);
    if (s > highScore) highScore = s;
  }
  score = 0.0;
  
  // misc
  divOffset = 0.0;
  divOffsetMax = width/4;
}


// do it
void draw() {
  background(200);
  if (died) {
    die();
  } else {
    gameplay();
  }
}


// any key restarts game
void keyPressed() {
  if (died) {
    died = false;
    setup();
  }
}


// circle/circle collission
boolean circleCircle(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {
  float distX = c1x - c2x;
  float distY = c1y - c2y;
  float distance = sqrt( (distX*distX) + (distY*distY) );
  if (distance <= c1r+c2r) {
    return true;
  }
  return false;
}