class Alien {
  
  PImage sprite = loadImage("Sprites/alien1.png");
  int health = 3;
  float x, y, s;
  boolean alive = true;
  
  Alien(float _x, float _y) {
    x = _x;
    y = _y;
  }
  
  void display(){
    
    if (alive){
      image(sprite, x, y);
    }
  }
  
  void move(){
    
    if (alive){
      //move down
      y += 0.5;
    
      x += 10 * sin(s);
      s += PI/48;
    }
    
  }
  
  void moveAlt(){
    
    if (alive){
      //move down
      y += 0.5;
    
      x -= 10 * sin(s);
      s += PI/48;
    }
    
  }
  float checkDist(Bullet b) {
    
    float dist = sqrt(sq(this.x - b.x) + sq(this.y - b.y));
    
    return dist;
    
  }
  
  
   void checkHit(Bullet b){
     
     if (alive){
      if (checkDist(b) <= 25){
<<<<<<< Updated upstream
        b.alive = false;
        this.alive = false;
=======
        if (health <=0){
          b.alive = false;
          this.alive = false;
          return (1);
        } else {
          b.alive = false;
          health--;
          return(0);
        }
      } else {
        return(0);
>>>>>>> Stashed changes
      }
     }
   }
}
