class Bullet {
  
  float x, y;
  boolean alive = true;
  
  Bullet(float _x, float _y){
    x = _x;
    y = _y;  
  }
  
  
  void move(){
    if (alive){
      y -= 5;
    }
  }
  
  void display(){
    if (alive){
      fill(0);
      ellipse(x,y,10,10);
    }
  }
}
