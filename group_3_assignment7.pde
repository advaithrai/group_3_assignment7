int score = 0;
int speed = 20;
int level = 1;

PImage bg;

Ship ship;
Bullet[] bullets;

Alien alien;

alienBullet[] ab;

void setup () {
  frameRate(60);
  size(500,500);
  bg = loadImage("Images/space.jpg");
  
  bullets = new Bullet[0];
  ab = new alienBullet[0];
  
  ship = new Ship(250,400);
  alien = new Alien(0,0);
}


void draw() {
  image(bg,0,0);
  textSize(14);
  text("Score: "+ score,400,20);
  text("Lives: " + ship.lives, 400,40);
  text("Level " + level, 10,20);
  
  for (Bullet bullet : bullets) {
    bullet.display();
    bullet.move();    

  }
  
  for (alienBullet a : ab) {
    a.display();
    a.move();
    ship.checkHitBullet(a);
  }  
 
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
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 10,ship.y -15));
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 30,ship.y -15));

  }
  
}

  
