<<<<<<< Updated upstream
<<<<<<< Updated upstream

=======
=======

>>>>>>> Stashed changes
int score = 10;
int speed = 20;
int level = 1;
int timer = 0;
<<<<<<< Updated upstream
int spawnTime = 6000;
=======
int timer2 = 0;
int spawnTime = 5000;
int spawnTime2 = 1500;
int numSeekers = 0;
int seekerX;

PImage bg;

Ship ship;
Bullet[] bullets;

Alien[] aliens;
Alien[] altAliens;

Alien[] aliens2;



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
  
  altAliens = new Alien[0];

  aliens2 = new Alien[0];

  
  ship = new Ship(250,400);
 
}

void levelUp() {
  if (score >= 10 && level == 1) {
    level = 2;

  } else if (score >= 30 && level == 2) {
    level = 3;

  }
}

void draw() {
  image(bg,250,250);
  textSize(14);
  
  text("Score: "+ score,400,20);
  text("Lives: " + ship.lives, 400,40);
  text("Level " + level, 10,20);
  
  levelUp();
  
  if ((millis() - timer) >= spawnTime){
    
    if (level == 1) {
      aliens = (Alien[])append(aliens, new Alien(100,-25)); 
      timer = millis();
    } else if (level == 2){
      
      aliens = (Alien[])append(aliens, new Alien(100,-25));
      altAliens = (Alien[])append(altAliens, new Alien(400,-25));
    
      timer = millis();
    }
  }
  

  while (numSeekers <= 4) {
    if ((millis() - timer2) >= spawnTime2){
      aliens2 = (Alien[])append(aliens2, new Alien(100,-25));
      numSeekers++;
    }
  }
  
  for (Alien alien : aliens2) {
    ship.checkHit(alien);
    alien.display();
    alien.move();
  }

    
  for (Alien alien : aliens) {
    ship.checkHit(alien);
    alien.display();
    alien.move();
  }
  
  for (Alien alien : altAliens) {
    ship.checkHit(alien);
    alien.display();
    alien.moveAlt();
  }

  
  
  
  for (Bullet bullet : bullets) {
    for (Alien alien : aliens){
      score += alien.checkHit(bullet);
    }
    
    for (Alien alien : altAliens){
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
  if (ship.isAlive()) {   
    ship.display(); 
        
  }
    
  else {
    textSize(30);
    text("Game Over", 180,250);
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

  }

void mouseClicked() {
  if (ship.isAlive()) {
   bullets = (Bullet[])append(bullets, new Bullet(ship.x - 12.5 ,ship.y -15));
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 12.5 ,ship.y -15));

  }
  
}
