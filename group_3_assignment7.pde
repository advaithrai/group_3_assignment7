int score = 0;
int health = 3;

Ship ship;

void setup () {
  size(500,500);

  
  ship = new Ship(250,400);
}

void draw() {
  background(0,0,0);
    
  ship.display();
  ship.keyPressed();

  
}
