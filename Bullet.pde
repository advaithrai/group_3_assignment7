class Bullet {
  
  float x, y;
  boolean alive = true;
  PImage bulletSprite = loadImage("Sprites/bullet.png");
  
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
      image(bulletSprite, x, y);
    }
  }
}

class alienBullet extends Bullet {
  
  Boolean hit = false;
  
  alienBullet(int x, int y) {
    super(x,y);
  }
  
    void move(){
    if (alive){
      y += 5;
    }
  }

}
