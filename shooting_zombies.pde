Shooter shooter ;
Zombie[] zombies ;
Bullet[] bullets;

void setup(){
  background(255);
  size(1200, 600);
  shooter = new Shooter(width/2, height/2);
  zombies = new Zombie[10];
  bullets = new Bullet[1000];
  for (int i = 0; i < zombies.length; i++){
    zombies[i] = new Zombie();
  }
}

void draw(){
  background(255);
  if (keyPressed == true){
    if (key == CODED){
        shooter.move(keyCode);
    }
  }
  fill(255);
  circle(shooter.positionX, shooter.positionY, shooter.size);
  fill(0);
  for (int i = 0; i < zombies.length; i++){
    zombies[i].move(shooter.positionX, shooter.positionY);
    zombies[i].kill(shooter.positionX, shooter.positionY);
  }
  shooter.shoot();   
  for (int i = 0; i < bullets.length; i++){
    if (bullets[i] != null){
      bullets[i].move();
    }
  }
  
  for (int j = 0; j < bullets.length; j ++){
    
    for (int i = 0; i < zombies.length; i ++){
      if (bullets[j] != null){
        if (dist(zombies[i].positionX, zombies[i].positionY, bullets[j].positionX, bullets[j].positionY) < 30){
          zombies[i] = new Zombie();
          
        }
      }
    }
  }
} 
 
class Shooter{
  float positionX, positionY, size, speed;
  
  Shooter(float positionX, float positionY){
    this.positionX = positionX ;
    this.positionY = positionY ;
    this.size = 50 ;
    this.speed = 2 ;
    circle(this.positionX, this.positionY, 50);
  }
  
  void move(float direction){
    if (direction == UP){
      this.positionY -= this.speed;
    }
    if (direction == DOWN){
      this.positionY += this.speed;
    }
    if (direction == LEFT){
      this.positionX -= this.speed;
    }
    if (direction == RIGHT){
      this.positionX += this.speed;
    }
    if (this.positionX > width) this.positionX = width;
    if (this.positionX < 0) this.positionX = 0 ;
    if (this.positionY > height) this.positionY = height;
    if (this.positionY < 0) this.positionY = 0 ;
    circle(this.positionX, this.positionY, this.size);
  }
  
  void shoot(){

      if (keyPressed && key == ' '){
        bullets = (Bullet[])append(bullets, new Bullet(this.positionX, this.positionY));
       
      }
  }
} 

class Bullet{
  float positionX , positionY, speed, size ;
  
  Bullet(float positionX, float positionY){
    this.positionX = positionX ;
    this.positionY = positionY ;
    this.speed = 4 ;
    this.size = 10 ;
    circle(this.positionX, this.positionY - 25, this.size);
  }
  
  void move(){
    if (this.positionY >= 0 ){
      this.positionY -= this.speed ;
      circle(this.positionX, this.positionY, this.size);
    } 
  }
  
}



class Zombie{
  float targetX, targetY, speed, positionX, positionY;
  
  Zombie(){
    this.targetX = positionX ;
    this.targetY = positionY ;
    this.positionX = random(0, 1200) ;
    this.positionY = 0 ;
    this.speed = 1 ;
    circle(this.positionX, this.positionY, 60);
  }
  
  void move(float targetX, float targetY){
    fill(0);
    if (this.positionX > targetX){
      this.positionX -= this.speed ;
    }
    if (this.positionX < targetX){
      this.positionX += this.speed ;
    }
    if (this.positionY < targetY){
      this.positionY += this.speed ;
    }
    if (this.positionY > targetY){
      this.positionY -= this.speed ;
    }
    circle(this.positionX, this.positionY, 60);
  }
  
  void kill(float positionX, float positionY){
    if (dist(this.positionX, this.positionY, positionX, positionY) < 50){
      exit();
    }
  }
}
