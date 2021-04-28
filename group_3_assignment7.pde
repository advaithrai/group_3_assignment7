int score = 0;
int speed = 20;
int level = 1;
int timer = 0;
int spawnTime = 6000;
int state = 0;
PImage bg;
boolean startButtonPressed;
boolean highScorePressed;
int startX, startY, startW, startH;
int highX, highY, highW, highH;

int[] scores = new int[5];
int[] scores_int = new int[5];
String file = "highscores.txt";


Ship ship;
Bullet[] bullets;

Alien[] aliens;


alienBullet[] ab;

void setup () {
  
  frameRate(60);
  size(500,500);
  imageMode(CENTER);
  bg = loadImage("Images/space.jpg");
  initHighScore();
 
  bullets = new Bullet[0];
  ab = new alienBullet[0];
  aliens = new Alien[0];
  aliens = (Alien[])append(aliens, new Alien(100,-25));
  ship = new Ship(250,400);
   
  }
   



void draw() {
  
  image(bg,250,250);
  textSize(14);
  switch(state){
  case 0:
    textSize(35);
    text("Main Menu",154, 150);
    startW = 200;
    startH = 80;
    startX = (width - startW) / 2;
    startY = 200;
    
    highW = 200;
    highH = 80;
    highX = (width - highW)/2;
    highY = 310;
    
    textSize(20);
    fill(150);  
    
    rect(startX, startY, startW, startH, 15);
    rect(highX, highY, highW, highH, 15);
    
    fill(255);
    text("Start Game",startX+45, startY+50);
    text("View High Scores", highX+18, highY+50);
    
    break;
    
  case 1:
    text("Score: "+ score,400,20);
    text("Lives: " + ship.lives, 400,40);
    text("Level " + level, 10,20);
    
    if ((millis() - timer) >= spawnTime){
      aliens = (Alien[])append(aliens, new Alien(100,-25));
      timer = millis();
    }
    
  
      
    for (Alien alien : aliens) {
      ship.checkHit(alien);
      alien.display();
      alien.move();
    }
  
    
    
    
    for (Bullet bullet : bullets) {
      for (Alien alien : aliens){
        score += alien.checkHit(bullet);
      }
      
      bullet.display();
      bullet.move();    
  
    }
  /*  
    for (alienBullet a : ab) {
      a.display();
      a.move();
      ship.checkHitBullet(a);
    }  
   */
   
   if(score >= 10){
      textSize(20);
      text("You Won! Press Enter to Play Again", 75,250);
      text("Press 'Q' to Quit", 175, 300);
      
      ship.alive = false;
      for (Alien alien : aliens) {
        alien.alive = false;
      }
    }
    
    if (ship.isAlive()) {   
      ship.display(); 
          
    }
      
    else {
      textSize(20);
      text("Game Over. Press Enter to Play Again", 75,250);
      text("Press 'Q' to Quit", 175, 300);
    }
    
    break;
    
  case 2:
    initHighScore();
    textSize(25);
    text("High Scores", width/2 - 68, 100);
    textSize(15);
    text("Press 'Q' to return to main menu", width/2 - 120, 450);
    for(int i = 0; i < scores.length; i++){
      textSize(20);
      textAlign(CENTER);
      if(scores[i] != 0){
        text(scores[i], width/2, 200+30*i);
      }
    }
    textAlign(LEFT);
    
  }
    
}
    

void keyPressed() {
     if (ship.isAlive() && state == 1) {
      if (key == 'w' && ship.y >= 0) {
        ship.y -= speed;        
      }
      if (key == 's' && ship.y <= 450) {
        ship.y += speed;
      }
      if (key == 'd' && ship.x <= 450) {
        ship.x += speed;
      }
      if (key == 'a' && ship.x >= 5) {
        ship.x -= speed;
      }
      if (key == 'q'){
        addScore(score);
        state = 0;
      }
     
     }
     
    
     if(ship.isAlive() == false && state == 1){
       if(key == 'q'){
         addScore(score);
         state = 0;
       }
     }
     
     if(state == 2){
       if(key == 'q'){
         state = 0;
       }
     }
     
     if (key == ENTER){
        bg = loadImage("Images/space.jpg");
        bullets = new Bullet[0];
        aliens = new Alien[0];
        aliens = (Alien[])append(aliens, new Alien(100,-25));
        ship = new Ship(250,400);
        addScore(score);
        score = 0;
     }
}
  

void mouseClicked() {
  if (ship.isAlive() && state ==1) {
   bullets = (Bullet[])append(bullets, new Bullet(ship.x - 12.5 ,ship.y -15));
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 12.5 ,ship.y -15));

  }
  
  if (mouseX > startX && mouseX < startX+startW && mouseY > startY && mouseY < startY+startH){
    startButtonPressed = true;
    state = 1;
  }
  
  if (mouseX > highX && mouseX < highX+highW && mouseY > highY && mouseY < highY+highH){
    highScorePressed = true;
    state = 2;
  }
  
  
}

void initHighScore(){
  for(int i = 0; i < scores_int.length; i++){
    scores_int[i] = 0;
  }
  
  String[] scoresAsStrings = null;
  scoresAsStrings = loadStrings(file);
  
  if(scoresAsStrings.length > 1 ){
    
    for(int i=0; i < scores_int.length; i++){
      scores_int[i] = int(scoresAsStrings[i]);
    }
    
    scores = sort(scores_int);
    scores = reverse(scores);
    
    
    
  }else{
    println("New Score initialized - first run\n");
  }
}

void addScore(int score){
  for(int i = 0; i < scores_int.length; i++){
    if (score >= scores_int[i]){
      for(int j=scores_int.length-1; j >= max(i, 1); j--){
        scores_int[j] = scores_int[j-1];
      }
      scores_int[i] = score;
      break;
    }
  }
  
  String[] scoresAsStrings = new String[scores_int.length];
  for(int i=0; i < scores_int.length; i++){
    scoresAsStrings[i] = str(scores_int[i]);
  }
  
  saveStrings(file, scoresAsStrings); 
}
      

    
  

  
