class Alien {
  
  PImage sprite = loadImage("Sprites/alien1.png");
  int health = 1;
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
      y += 0.2;
    
      x += 5 * sin(s);
      s += PI/96;
    }
    
  }
  
  float checkDist(Bullet b) {
    
    float dist = sqrt(sq(this.x - b.x) + sq(this.y - b.y));
    
    return dist;
    
  }
  
  
   void checkHit(Bullet b){
     
     if (alive){
      if (checkDist(b) <= 25){
        b.alive = false;
        this.alive = false;
        score += 1;
      }
     }
   }
}
