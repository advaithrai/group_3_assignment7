int score = 0;
int speed = 20;

Ship ship;

Bullet[] bullets;

void setup () {
  frameRate(60);
  size(500,500);
  bullets = new Bullet[0];
  
  ship = new Ship(250,400);
}

void draw() {
  background(0,0,0);
  
  for (Bullet bullet : bullets) {
    bullet.display();
    bullet.move();
    

  }
    
  
  ship.display();
  


  
}

  void keyPressed() {
   
      if (key == 'w') {
        ship.y -= speed;
        println("up");
        
      }
      if (key == 's') {
        ship.y += speed;
        println("down");
      }
      if (key == 'd') {
        ship.x += speed;
        println("right");
      }
      if (key == 'a') {
        ship.x -= speed;
        println("left");
      }
    

  }


void mouseClicked() {
  
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 10,ship.y -15));
   bullets = (Bullet[])append(bullets, new Bullet(ship.x + 30,ship.y -15));
  
}

  
