class Ship {
  
  PImage shipSprite = loadImage("Sprites/ship.png");
  PImage deadSprite = loadImage("Sprites/death-2.png");
  int x;
  int y;
  int lives = 3;
  Boolean alive = true;
  int timer = 0;
  int timerValue = 30;
  
  Ship(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    image(shipSprite, x, y);
  }

  float checkDist(Alien b) {
    
    float dist = sqrt(sq(this.x - b.x) + sq(this.y - b.y));
    
    return dist;
    
  }
  
    float checkDistBullet(alienBullet b) {
    
    float dist = sqrt(sq(this.x - b.x) + sq(this.y - b.y));
    
    return dist;
    
  }
  
  void die() {
      if (!this.alive && timer < timerValue) {
    
      image(deadSprite, x,y);
      timer++;
      }

  }

  void newMove() {
      
   if (!keysOn) {
    int newX = abs(mouseX - ship.x);
    int newY = abs(mouseY - ship.y);
   
    if (ship.x > mouseX) {
      ship.x -= newX;
    }
    else if (ship.x < mouseX) {
      ship.x += newX;
    }
    
    if (ship.y < mouseY) {
      ship.y += newY;
    }
    else if (ship.y > mouseY) {
      ship.y -= newY;
    }
   }
   

  }
  
  Boolean isAlive() {
     if (this.lives <= 0) {
          this.alive = false;

          return false;
        }
    else {
 //     println("alive");
      return true;
    }
  }
  
   void checkHit(Alien b){
     
     
     if (this.alive && !b.hit){
      if (checkDist(b) <= 25){
        b.alive = false;
        b.hit = true;
        this.lives -= 1;

      }
     }
   }
   
   void checkHitBullet(alienBullet b){
     
     if (this.alive){
      if (checkDistBullet(b) <= 25 && !b.hit){
        b.alive = false;
        b.hit = true;
        this.lives -= 1;

      }
     }
   }
  

  }
