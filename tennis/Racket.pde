class Racket {
  int x_coord;
  int y_coord;
  int x_size = 100;
  int y_size = 20;
  int x_size2 = 50;
  int y_size2 = 10;
  float speed = 9;
  String name;
  boolean mouse = false;
  int button_left;
  int button_right;
  color fill_color = color(255);
  
  Racket(int x_coor, int y_coor, String nam, boolean mous, 
          int button_lef, int button_righ) {
    x_coord = x_coor;
    y_coord = y_coor;
    mouse = mous;
    button_left = button_lef;
    button_right = button_righ;
    if(mouse == true)
      button_left = button_righ = -1;
    name = nam;
  }

  Racket(int x_coor, int y_coor, String nam, int x_siz, int y_siz, 
    float spee, boolean mous, int button_lef, int button_righ, color fill_colo) {
    this(x_coor, y_coor, nam, mous, button_lef, button_righ);
    x_size = x_siz;
    x_size2 = x_size/2;
    y_size = y_siz;
    y_size2 = y_size/2;
    speed = spee;
    fill_color = fill_colo;
  }

  void display() {
    fill(fill_color);
    stroke(0);
    rectMode(CENTER);
    if(mouse == true)
      x_coord = mouseX;
    rect(x_coord, y_coord, x_size, y_size);
    //println(x_coord + "  TUSAM  " + y_coord);
  }  

  void checkPressedKey(int pressedKey) {
    if(mouse == true)
      return;
    if (pressedKey == button_left && x_coord >= 0)
      x_coord -= speed;
    else if (pressedKey == button_right && x_coord <= width)
      x_coord += speed;
    //println("stisnut je " + pressedKey);
  }
  
  void changeBallSpeed(Ball ball) {
    float maxSpeed = 3;
    
    //TODO Diff treba popraviti
    //diff is number between 0 and 1 and describe
    //which part of racked ball hit.
    float diff = float(ball.getPosX() - ball.getSizeX() - x_coord - x_size2) / x_size;
    
    //we want for speed to be between 0 and maxSpeed.
    float newSpeedX = (diff-0.5)*maxSpeed*1.5;
    ball.setSpeedX(newSpeedX);

    //TODO Here we should decide how speed by y axes shoud be modified.
    ball.setSpeedY(-ball.getSpeedY());

    println("nova brzina je: (" + ball.getSpeedX() + ","  + ball.getSpeedY() + ")");
  
  }
  
  void strike(Ball ball) {
    //TODO treba provjeriti kada dolazi do udarca u reket i da li je ovako dobro
    
    int ballX = ball.getPosX();
    //println("Koord X = " + x_coord + "-" + (x_coord + x_size) + " lopta = " + ballX);
    if(ballX < x_coord - x_size2 || ballX > x_coord + x_size2)
      return;
    int ballY = ball.getPosY();
    //println("Koord Y = " + y_coord + "-" + (y_coord + y_size) + " lopta = " + ballY);
    if(ballY < y_coord - y_size2 || ballY > y_coord + y_size2)
      return;
   
    println("Doslo je do udarca");
    changeBallSpeed(ball);
  }
}