import processing.sound.*;

SoundFile bgFile;
String bgMusic = "Sounds/galaga.mp3";
String bgPath;

SoundFile laser;
String laserSound = "Sounds/laser.mp3";
String laserPath;

PFont galaga_font;

int score = 0;
int speed = 10;
int level = 1;
int timer = 0;
int timer2 = 0;
int startTime2;
int spawnTime = 3000;
int spawnTime2 = 1500;
int delay2 = 5000;
int numSeekers = 0;
int seekerX = 0;
boolean bossExist = false;
int state = 0;
PImage bg;
boolean startButtonPressed;
boolean highScorePressed;
boolean resumePressed;
boolean restartPressed;
int startX, startY, startW, startH;
int highX, highY, highW, highH;
int resumeX, resumeY, resumeW, resumeH;
int restartX, restartY, restartW, restartH;
Boolean soundOn = true;
Boolean keysOn = true;

int[] scores = new int[5];
int[] scores_int = new int[5];
String file = "highscores.txt";


Ship ship;
Bullet[] bullets;

Alien[] aliens;
Seeker[] aliens2;
Alien[] altAliens;
Boss boss;
alienBullet[] ab;
bossBullet[] bb;

void setup () {
  
  
  galaga_font = createFont("Emulogic", 32);
  textFont(galaga_font);
  frameRate(60);
  size(500,500);
  imageMode(CENTER);
  bg = loadImage("Images/space.jpg");
  initHighScore();
  
  bgPath = sketchPath(bgMusic);
  bgFile = new SoundFile(this, bgPath);
  bgFile.amp(.3);
  bgFile.play();
  
  laserPath = sketchPath(laserSound);
  laser = new SoundFile(this, laserPath);
  laser.amp(.3);


 
  bullets = new Bullet[0];
  ab = new alienBullet[0];
  bb = new bossBullet[0];
  aliens = new Alien[0];
  altAliens = new Alien[0];
  aliens2 = new Seeker[0];
  
  ship = new Ship(250,400);
   
  }
   
void levelUp() {
  if (score >= 10 && level == 1) {
    level = 2;
    startTime2 = millis();

  } else if (score >= 30 && level == 2) {
    level = 3;
    numSeekers = 0;
    seekerX = 0;

  }
}


void draw() {
  
  image(bg,250,250);
  textSize(14);
  
  if (keyPressed) {
    WASD();
  }
  
  switch(state){
  case 0:
    textSize(36);
    fill(25, 255, 29);
    text("Main Menu", 90, 150);
    startW = 200;
    startH = 80;
    startX = (width - startW) / 2;
    startY = 200;
    
    highW = 230;
    highH = 80;
    highX = (width - highW)/2;
    highY = 310;
    
    textSize(18);
    stroke(25, 255, 29);
    noFill();
    
    rect(startX, startY, startW, startH, 25);
    rect(highX, highY, highW, highH, 25);
    
    fill(255);
    text("Start Game",startX + 10, startY + 50);
    text("High Scores", highX + 15, highY + 50);
    
    break;
    
  case 1:
  
    levelUp();
    
    
    if ((millis() - timer) >= spawnTime){
      if (level == 1) {
        aliens = (Alien[])append(aliens, new Alien(100,-25)); 
        timer = millis();
      } else if (level == 2 || level == 3){
      
        aliens = (Alien[])append(aliens, new Alien(100,-25));
        altAliens = (Alien[])append(altAliens, new Alien(400,-25));
        
        if (millis() - startTime2 >= delay2){
          if ((millis() - timer2) >= spawnTime2 && numSeekers <= 3){
            aliens2 = (Seeker[])append(aliens2, new Seeker(100 + seekerX,-25));
            seekerX += width/5;
            numSeekers++;
            timer2 = millis();
          }
        }
        timer = millis();
      }
    }

    if (level == 3) {
        
      if (!bossExist) {
        boss = new Boss(125, 0);
        bossExist = true;
      }
      
      boss.display();
      boss.move();
      
   
    }
    
    
    for (Seeker alien : aliens2) {
      ship.checkHit(alien);
      alien.display();
      alien.move();
      alien.die();
    }
    
    for (Alien alien : aliens) {
      ship.checkHit(alien);
      alien.display();
      alien.move();
      alien.die();
    }
    
    for (Alien alien : altAliens) {
      ship.checkHit(alien);
      alien.display();
      alien.moveAlt();
      alien.die();
    }
  
    for (Bullet bullet : bullets) {
      for (Alien alien : aliens){
        score += alien.checkHit(bullet);
      }
      for (Alien alien : altAliens){
        score += alien.checkHit(bullet);
      }
      for (Alien alien : aliens2){
        score += alien.checkHit(bullet);
      }
      
      if (level == 3){
        score += boss.checkHit(bullet);
      }
      
      bullet.display();
      bullet.move();    
  
    }
    
    for (alienBullet a : ab) {
      a.display();
      a.move();
      ship.checkHitBullet(a);
    }
    
    for (bossBullet b : bb) {
      b.display();
      b.move();
      ship.checkHitBullet(b);
    }
   
   
   textSize(12);
   text("Score: "+ score,375,20);
   text("Lives: " + ship.lives, 375,40);
   text("Level " + level, 10,20);
    
   if(score >= 80){
      state = 5;
      
      ship.alive = false;
      for (Alien alien : aliens) {
        alien.alive = false;
      }
    }
    
    if (ship.isAlive()) {   
      ship.display();
      
          
    }
      
    else {
      ship.die();
      state = 4;
    
    }
    
    break;
    
  case 2:
    initHighScore();
    fill(255);
    textSize(24);
    text("High Scores", 125 , 100);
    textSize(12);
    text("Press 'Q' to return to main menu", 50, 450);
    for(int i = 0; i < scores.length; i++){
      textSize(20);
      textAlign(CENTER);
      if(scores[i] != 0){
        
        text(i+1 + "." + scores[i], width/2, 200+30*i);
      }
    }
    textAlign(LEFT);
    break;
   
   case 3:
     bg = loadImage("Images/space.jpg");
     image(bg,250,250);
     textSize(12);
     text("Score: "+ score,375,20);
     text("Lives: " + ship.lives, 375,40);
     text("Level " + level, 10,20);
     textSize(24);
     fill(255);
     text("Paused", 175, 175);
     
     resumeW = 200;
     resumeH = 80;
     resumeX = (width - resumeW) / 2;
     resumeY = 200;
    
     restartW = 210;
     restartH = 80;
     restartX = (width - restartW)/2;
     restartY = 310;
    
     textSize(18);  
      
     stroke(25, 255, 29);
     noFill();
     rect(resumeX, resumeY, resumeW, resumeH, 25);
     rect(restartX, restartY, restartW, restartH, 25);
    
     fill(255);
     text("Resume",resumeX + 45, resumeY + 50);
     text("Start Over", restartX + 15, restartY + 50);
    
     break;
     
    case 4:
      
      bg = loadImage("Images/space.jpg");
      bullets = new Bullet[0];
      ab = new alienBullet[0];
      bb = new bossBullet[0];
      aliens = new Alien[0];
      altAliens = new Alien[0];
      aliens2 = new Seeker[0];
      
      aliens = (Alien[])append(aliens, new Alien(100,-25));
      
      
      image(bg,250,250);
      textSize(12);
      text("Score: "+ score,375,20);
      text("Lives: " + ship.lives, 375,40);
      text("Level " + level, 10,20);
      textSize(24);
      fill(255);
      
      text("Game Over", 140, 175);
     
      resumeW = 200;
      resumeH = 80;
      resumeX = (width - resumeW) / 2;
      resumeY = 200;
    
      restartW = 210;
      restartH = 80;
      restartX = (width - restartW)/2;
      restartY = 310;
    
      textSize(18);  
      
      stroke(25, 255, 29);
      noFill();
      rect(resumeX, resumeY, resumeW, resumeH, 25);
      rect(restartX, restartY, restartW, restartH, 25);
    
      fill(255);
      text("Main Menu",resumeX + 20, resumeY + 50);
      text("Start Over", restartX + 15, restartY + 50);
       
      break;
      
    case 5:
      bg = loadImage("Images/space.jpg");
      bullets = new Bullet[0];
      ab = new alienBullet[0];
      bb = new bossBullet[0];
      aliens = new Alien[0];
      altAliens = new Alien[0];
      aliens2 = new Seeker[0];
        
      aliens = (Alien[])append(aliens, new Alien(100,-25));
        
        
      image(bg,250,250);
      textSize(12);
      text("Score: "+ score,375,20);
      text("Lives: " + ship.lives, 375,40);
      text("Level " + level, 10,20);
      textSize(24);
      fill(255);
        
      text("You Won!", 150, 175);
       
      resumeW = 200;
      resumeH = 80;
      resumeX = (width - resumeW) / 2;
      resumeY = 200;
      
      restartW = 210;
      restartH = 80;
      restartX = (width - restartW)/2;
      restartY = 310;
      
      textSize(18);  
        
      stroke(25, 255, 29);
      noFill();
      rect(resumeX, resumeY, resumeW, resumeH, 25);
      rect(restartX, restartY, restartW, restartH, 25);
      
      fill(255);
      text("Main Menu",resumeX + 20, resumeY + 50);
      text("Start Over", restartX + 15, restartY + 50);
         
      break;
  }
    
}

void WASD() {
       if (ship.isAlive() && state == 1 && keysOn) {
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

}

void keyPressed() {
      if (key == 'n') {
        if (soundOn) {
          bgFile.pause();
          
          soundOn = false;
        }
        else {
          bgFile.play();
          soundOn = true;
        }
      }
      
      if (key == 'k') {
        if (keysOn) {
          keysOn = false;
        }
        else {
          keysOn = true;
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
     
     if (keyPressed && key == ' '){
       if(state == 1){
         state = 3;
       }
       else if (state == 3){
         state = 1;
       }
     
     }
     
     if (state == 3){
       if (key == ENTER || key == RETURN){
        state = 1;
        bg = loadImage("Images/space.jpg");
        bullets = new Bullet[0];
        ab = new alienBullet[0];
        bb = new bossBullet[0];
        aliens = new Alien[0];
        altAliens = new Alien[0];
        aliens2 = new Seeker[0];
        aliens = (Alien[])append(aliens, new Alien(100,-25));
        ship = new Ship(250,400);
        addScore(score);
        score = 0;
       }
     }
     
}

void mouseMoved() {
  ship.newMove();
}

void mouseDragged() {
  ship.newMove();
  }

void mousePressed() {
  if (ship.isAlive() && state ==1) {
    if (soundOn) {
    laser.play();
    }
   bullets = (Bullet[])append(bullets, new Bullet(ship.x - 12.5 ,ship.y -15));
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 12.5 ,ship.y -15));

  }

}

void mouseClicked() {
  
  if (mouseX > startX && mouseX < startX+startW && mouseY > startY && mouseY < startY+startH && state == 0){
    startButtonPressed = true;
    state = 1;
    level = 1;
    bg = loadImage("Images/space.jpg");
    bullets = new Bullet[0];
    ab = new alienBullet[0];
    bb = new bossBullet[0];
    aliens = new Alien[0];
    altAliens = new Alien[0];
    aliens2 = new Seeker[0];
    aliens = (Alien[])append(aliens, new Alien(100,-25));
    ship = new Ship(250,400);
    addScore(score);
    score = 0;
    
  }
  
  if (mouseX > highX && mouseX < highX+highW && mouseY > highY && mouseY < highY+highH && state == 0){
    highScorePressed = true;
    state = 2;
  }
  
  if (mouseX > resumeX && mouseX < resumeX+resumeW && mouseY > resumeY && mouseY < resumeY+resumeH){
    if (state == 3){
      state = 1; 
    }else if (state == 4 || state == 5){
      state = 0;
    }
  }
  
  if (mouseX > restartX && mouseX < restartX+restartW && mouseY > restartY && mouseY < restartY+restartH && (state == 3 || state == 4 || state == 5)){
    restartPressed = true;
    state = 1;
    bg = loadImage("Images/space.jpg");
    bullets = new Bullet[0];
    ab = new alienBullet[0];
    bb = new bossBullet[0];
    aliens = new Alien[0];
    altAliens = new Alien[0];
    aliens2 = new Seeker[0];
    aliens = (Alien[])append(aliens, new Alien(100,-25));
    ship = new Ship(250,400);
    addScore(score);
    score = 0;
    
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
      

    
  

  
