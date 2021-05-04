class Alien {
  
  PImage sprite = loadImage("Sprites/alien1.png");
  PImage deadSprite = loadImage("Sprites/death-2.png");
  int health = 1;
  float x, y, s;
  boolean alive = true;
  boolean hit = false;
  int timer = 0;
  int timerValue =10;
  int bulletTimerValue = 2000;
  int bulletTimer = 0;
  
  
  Alien(float _x, float _y) {
    x = _x;
    y = _y;
  }
  
  void display(){
    
    if (alive){
      image(sprite, x, y);
    }
  }
  
  void die() {
      if (!this.alive && timer < timerValue) {
    
      image(deadSprite, x,y);
      timer++;
    
      }
  }
  
  void move(){
    
    if (alive){
      //move down
      y += 0.5;
    
      x += 10 * sin(s);
      s += PI/48;
    }
    
    if (((millis() - bulletTimer) >= bulletTimerValue) && this.alive) {
        bulletTimer = millis();
        ab = (alienBullet[])append(ab, new alienBullet(this.x - 12.5 ,this.y + 15));
        ab = (alienBullet[])append(ab, new alienBullet(this.x + 12.5 ,this.y + 15));
    }
    
  }
  
  void moveAlt(){
    
    if (alive){
      //move down
      y += 0.5;
    
      x -= 10 * sin(s);
      s += PI/48;
    }
    
    if (((millis() - bulletTimer) >= bulletTimerValue) && this.alive) {
        bulletTimer = millis();
        ab = (alienBullet[])append(ab, new alienBullet(this.x - 12.5 ,this.y + 15));
        ab = (alienBullet[])append(ab, new alienBullet(this.x + 12.5 ,this.y + 15));
    }
 
  }
  
  float checkDist(Bullet b) {
    
    float dist = sqrt(sq(this.x - b.x) + sq(this.y - b.y));
    
    return dist;
    
  }
  
  
   int checkHit(Bullet b){
     
     if (this.alive && b.alive && !b.hit){
      if (checkDist(b) <= 25){
        println(health);
        b.alive = false;
        b.hit = true;
        this.health --;
        if (this.health <= 0) {
          this.alive = false;
          return (1);
        } else {
          return (0);
        }
      } else {
        return(0);
      }
      
     }
     else {
       return(0);
     }
   }

}

class Seeker extends Alien {
  int health = 3;
  PImage sprite = loadImage("Sprites/alien2.png");
  boolean up = false;
  
  Seeker(float _x, float _y){
    super(_x,_y);
  }
  
  void move(){
    if (alive){
      
      if (!up){
        y += 5;
        
        if (y >= 550){
          up = true;
        }
      } else {
        y -= 5;
        if (y <= -50){
          up = false;
        }
      }
    }
  }
  
  void display(){
    
    if (alive){
      if (!up){
        pushMatrix();
        translate(x,y);
        image(sprite, 0, 0);
        popMatrix();
      } else {
        pushMatrix();
       
        translate(x,y);
        rotate(radians(180));
        image(sprite, 0, 0);
        popMatrix();
      }
      
    }
  }
  
  int checkHit(Bullet b){
     
     if (this.alive && b.alive && !b.hit){
      if (checkDist(b) <= 25){
        
        b.alive = false;
        b.hit = true;
        this.health --;
        if (this.health <= 0) {
          this.alive = false;
          return (3);
        } else {
          return (0);
        }
      } else {
        return(0);
      }
      
     }
     else {
       return(0);
     }
   }
}

class Boss extends Alien {
  int health = 50;
  PImage sprite = loadImage("Sprites/alien3.png");
  
  
  Boss(float _x, float _y){
    super(_x,_y);
  }
  
  void move(){
    if (alive){
      x += 2 * sin(s);
      s += PI/192;
      
      if (((millis() - bulletTimer) >= bulletTimerValue) && this.alive) {
        bulletTimer = millis();
        bb = (bossBullet[])append(bb, new bossBullet(this.x ,this.y + 55));
      }
    }
  }
  
  void display(){
    
    if (alive){     
      pushMatrix();
      translate(x,y);
      image(sprite, 0, 0);
      popMatrix();
    }
  }
  
  int checkHit(Bullet b){
     
     if (this.alive && b.alive && !b.hit){
      if (checkDist(b) <= 25){
        println(health);
        b.alive = false;
        b.hit = true;
        this.health --;
        if (this.health <= 0) {
          this.alive = false;
          return (50);
        } else {
          return (0);
        }
      } else {
        return(0);
      }
      
     }
     else {
       return(0);
     }
   }
}
