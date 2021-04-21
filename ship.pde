class Ship {
  
  PImage shipSprite = loadImage("Sprites/ship.png");
  int x;
  int y;
  int lives = 3;
  Boolean alive = true;
  
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

  
  Boolean isAlive() {
     if (this.lives <= 0) {
          this.alive = false;
//          println("dead");
          return false;
        }
    else {
 //     println("alive");
      return true;
    }
  }
  
   void checkHit(Alien b){
     
     if (this.alive){
      if (checkDist(b) <= 25){
        b.alive = false;
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
