class Ball{
  int x_coord = width/2;
  int y_coord = height/2;
  int x_size = 40;
  int y_size = 40;
  float speed_x = 1;
  float speed_y = 3;
  color fill_color = color(255);
  
  Ball() {
  }
  
  Ball(int x_coor, int y_coor, int x_siz, int y_siz, 
          float speed_xx, float speed_yy, color fill_colo) {
    x_coord = x_coor;
    y_coord = y_coor;
    x_size = x_siz;
    y_size = y_siz;
    speed_x = speed_xx;
    speed_x = speed_yy;
    fill_color = fill_colo;
  }

  void display() {
    fill(fill_color);
    stroke(0);
    ellipseMode(CENTER);
    ellipse(x_coord, y_coord, x_size, y_size);
    //println(x_coord + "  TUSAM  " + y_coord);
  }   
  
  int getPosX() {
    return x_coord;
  }
  
  int getPosY() {
    return y_coord;
  }
  
  int getSizeX() {
    return x_size;
  }
  
  float getSpeedX() {
    return speed_x;
  }
  
  float getSpeedY() {
    return speed_y;
  }
  
  void setSpeedX(float newSpeedX) {
    if(newSpeedX >= -15 && newSpeedX < 15)
      speed_x = newSpeedX;
  }
  
  void setSpeedY(float newSpeedY) {
    if(newSpeedY >= -15 && newSpeedY < 15) {
      speed_y = newSpeedY;
      println("Nova y brzina " + speed_y);
    }  
  }
  
  void update() {
   
    //TODO pogledati mozda treba malo popraviti u kojoj tocki dolazi do udara u zid
    y_coord += speed_y;
    if(y_coord <= 0 || y_coord >= height)
       gameOver();
   
    if(speed_x < 0 && x_coord + speed_x - x_size/ 2 < 0)
      x_coord = x_size/2;
    else if(speed_x > 0 && x_coord + speed_x + x_size/2 > width)
       x_coord = width - x_size/2;
    else
      x_coord += speed_x;
    
    if(x_coord == x_size/2 || x_coord == width - x_size/2)
      hitWall();
   
  }
 
  
  void hitWall() {
    println("TTTUU" + speed_y);
    if(speed_x < 0)
      speed_x = random(4,5);
    else
      speed_x = -random(4,5);
    
    println("Nova x brzina je " + speed_x +  "koordinate su " + x_coord + ", " + y_coord);
    //x_coord += speed_x;
  }
  
  void gameOver() {
    println("Pao je gol");
    exit();
  }
  
  
}