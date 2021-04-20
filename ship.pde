class Ship {
  
  PImage shipSprite = loadImage("Sprites/ship.png");
  int x;
  int y;

  
  Ship(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    image(shipSprite, x, y);
  }
  
  void keyPressed() {
    if (key == CODED) {
      if (keyCode == UP) {
        this.y -= 4;
        println("up");
        
      }
      if (keyCode == DOWN) {
        this.y += 4;
        println("down");
      }
      if (keyCode == RIGHT) {
        this.x += 4;
        println("right");
      }
      if (keyCode == LEFT) {
        this.x -= 4;
        println("left");
      }
    }
  
  }
  

}
