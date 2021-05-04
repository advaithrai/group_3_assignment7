class Bullet {
  
  float x, y;
  boolean alive = true;
  boolean hit = false;
  PImage bulletSprite = loadImage("Sprites/bullet.png");
  
  Bullet(float _x, float _y){
    x = _x;
    y = _y;  
  }
  
  
  void move(){
    if (alive){
      
      if (y <= 0){
        this.alive = false;
      } else {
        y -= 5;
      }
      
    }
  }
  
  void display(){
    if (alive){
      image(bulletSprite, x, y);
    }
  }
}

class alienBullet extends Bullet {
 
  PImage bullet = loadImage("Sprites/alienBullet.png");
 
  alienBullet(float x, float y) {
    super(x,y);
  }
  
    void move(){
    if (alive){
      
      if (y >= 500) {
        this.alive = false;
        this.hit = true;
      }
      else {
      y += 5;
      }
    }
  }
  
    void display(){
    if (alive){
      image(bullet, x, y);
    }
  }



}
