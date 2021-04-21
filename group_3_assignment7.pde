int score = 0;
int speed = 20;
int level = 1;
int timer = 0;
int spawnTime = 6000;
PImage bg;

Ship ship;
Bullet[] bullets;

Alien[] aliens;


alienBullet[] ab;

void setup () {
  frameRate(60);
  size(500,500);
  imageMode(CENTER);
  bg = loadImage("Images/space.jpg");
  
  bullets = new Bullet[0];
  ab = new alienBullet[0];
  aliens = new Alien[0];
  aliens = (Alien[])append(aliens, new Alien(100,-25));
  ship = new Ship(250,400);
 
}


void draw() {
  image(bg,250,250);
  textSize(14);
  
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
    text("You Won! Press Enter to Play Again", 80,250);
    
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
    text("Game Over. Press Enter to Play Again", 80,250);
  }
  
  
}

void keyPressed() {
     if (ship.isAlive()) {
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
      
     }
     if (key == ENTER){
        bg = loadImage("Images/space.jpg");
        bullets = new Bullet[0];
        aliens = new Alien[0];
        aliens = (Alien[])append(aliens, new Alien(100,-25));
        ship = new Ship(250,400);
        score = 0;
      }
  }

void mouseClicked() {
  if (ship.isAlive()) {
   bullets = (Bullet[])append(bullets, new Bullet(ship.x - 12.5 ,ship.y -15));
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 12.5 ,ship.y -15));

  }
  
}

  
