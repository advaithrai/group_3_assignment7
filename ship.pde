class Ship {
  
  PImage shipSprite = loadImage("Sprites/ship.png");
  int x;
  int y;
  int lives = 3;
  
  
  Ship(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    image(shipSprite, x, y);
  }
  
  Boolean isAlive() {
    if (this.lives >= 0) {
      return false;
    }
    else {
      return true;
    }
  }
  
  float checkDist(Bullet b) {
    
    float dist = sqrt(sq(this.x - b.x) + sq(this.y - b.y));
    
    return dist;
    
  }
  
   void checkHit(Bullet b){
     
     if (isAlive()){
      if (checkDist(b) <= 25){
        b.alive = false;
        this.lives -= 1;
      }
     }
   }

  

  }
