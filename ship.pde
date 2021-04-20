class Ship {
  
  PImage shipSprite = loadImage("assets/ship.png");
  int x;
  int y;
  
  Ship(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    image(shipSprite, x, y);
  }
  
  void move() {
  
  }
}
