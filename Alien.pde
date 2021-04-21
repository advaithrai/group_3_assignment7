class Alien {
  
  PImage sprite = loadImage("Sprites/alien1.png");
  int health = 1;
  float x, y, s;
  boolean alive = true;
  boolean hit = false;
  int timer = 0;
  int timerValue = 3000;
  
  
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
  
  
   int checkHit(Bullet b){
     
     if (this.alive && b.alive){
      if (checkDist(b) <= 25){
        b.alive = false;
        this.alive = false;
        return (1);
      } else {
        return(0);
      }
      
     }
     else {
       return(0);
     }
   }

}
