//int distanceFromEnd = 200;

/**
 * Class representing racket in game.
 * Class is responsible for displaying, moving racket and interacting
 * between rackets and ball throughout the game.
 */
class Racket {
  // Default starting position width.
  int x_coord;
  // Default starting position height.
  int y_coord;

  // Default starting size width.
  int x_size = 100;
  // Default starting size height.
  int y_size = 20;

  //Default starting moving speed.
  float speed = x_size/4;

  //Player name.
  String name;

  //Boolean value that determine if player is moving by mouse.
  //False means player is playing by keyboard.
  boolean mouse = false;
  //Code for button for moving left.
  int button_left;
  //Code for button for moving right.
  int button_right;
  // Default starting filling color.
  color fill_color = color(255);

  //TODO maybe add static variable so just one player can play by mouse.
  //TODO maybe add static list of all taken buttons for playing for checking newly added.

  /**
   * Constructor with basic starting values.
   * After constructing player is ready to start playing.
   * @param x_coor      Starting width position, must be between 0 and screen width.
   * @param y_coor      Starting height position, must be between 0 and screen height.
   * @param nam         Player name.
   * @param mous        Boolean value that decide if player is playing via mouse.
   * @param button_lef  Int code for button for moving left.
   * @param button_righ Int code for button for moving right.
   */
  Racket(int x_coor, int y_coor, String nam, boolean mous,
          int button_lef, int button_righ) {

    x_coord = x_coor;
    if(x_coord < 0 || x_coord > width - distanceFromEnd)
        x_coord = width/2;

    y_coord = y_coor;
    if(y_coord < distanceFromEnd || y_coord > height - distanceFromEnd)
        y_coord = height/2;

    mouse = mous;

    button_left = button_lef;
    button_right = button_righ;

    if(mouse == true)
      button_left = button_righ = -1;

    name = nam;
  }

  /**
   * Constructor with more detailed starting values.
   * After constructing player is ready to start playing.
   * @param x_coor      Starting width position, must be between 0 and screen width.
   * @param y_coor      Starting height position, must be between 0 and screen height.
   * @param nam         Player name.
   * @param x_siz       Starting size width, must be between 10 and width/5.
   * @param y_siz       Starting size width, must be between 5 and height/10.
   * @param spee        Starting speed, best between 5 and x_size.
   * @param mous        Boolean value that decide if player is playing via mouse.
   * @param button_lef  Int code for button for moving left.
   * @param button_righ Int code for button for moving right.
   * @param fill_colo   Racket filling color.
   */
  Racket(int x_coor, int y_coor, String nam, int x_siz, int y_siz,
    float spee, boolean mous, int button_lef, int button_righ, color fill_colo) {
    //Calling more general construct.
    this(x_coor, y_coor, nam, mous, button_lef, button_righ);

    if(x_siz > 10 && x_siz < width/5)
        x_size = x_siz;

    if(y_siz > 5 && y_siz < height/10)
        y_size = y_siz;

    speed = spee;

    fill_color = fill_colo;
  }


  /**
   * Function for drawing current position of racket on screen.
   */
  void display() {
    fill(fill_color);
    stroke(0);
    //rectMode(CENTER);

    //We have 2 different cases depending if player is using mouse.
    if(mouse == true)
      x_coord = mouseX;

    if(x_coord < 0)
      x_coord = 0;
    if(x_coord + x_size > width)
      x_coord = width - x_size;

    //Drawing racket on screen.
    rect(x_coord, y_coord, x_size, y_size);

    //println(x_coord + "  TUSAM  " + y_coord);
  }


  /**
   * Function that keyPressed function from main calls on each player to
   * see which player wants to be moved.
   * @param pressedKey Int describing pressed button.
   */
  void checkPressedKey(int pressedKey) {
    if(mouse == true)
      return;

    if (pressedKey == button_left && x_coord >= 0)
      x_coord -= speed;
    else if (pressedKey == button_right && x_coord + x_size <= width)
      x_coord += speed;

    //println("stisnut je " + pressedKey);
  }

  /**
   * Auxiliary function that modify current ball speed and direction after
   * hitting it with racket.
   * @param ball Ball on which we will change direction and/or speed.
   */
  void changeBallSpeed(Ball ball) {

    //diff is number between 0 and 1 and describe
    //which part of racked ball hit.
    float diff = float(ball.getPosX() - x_coord) / x_size;

    //We want for speed to be between 0 and maxBallSpeed.
    float newSpeedX = (diff-0.5)*maxBallSpeed*1.5;
    ball.setSpeedX(newSpeedX);

    //TODO Here we should decide how speed by y axes shoud be modified.
    ball.setSpeedY(-ball.getSpeedY());

    //println("nova brzina je: (" + ball.getSpeedX() + ","  + ball.getSpeedY() + ")");

  }

  /**
   * Function that is called after each frame to see if ether player hit the ball.
   * @param ball Ball instance on which we are looking if current player made contact.
   */
  void strike(Ball ball) {

    int ballX = ball.getPosX();

    //Check if the ball is in same width like our racket.
    if(ballX < x_coord || ballX > x_coord + x_size)
      return;

    //Check if the ball is in same height like our racket.
    //TODO this part maybe should looks a bit different. Think about how can we say if the ball hit racket.
    int ballY = ball.getPosY();
    if(ballY < y_coord || ballY > y_coord + y_size)
      return;

    //If executing code come to here, means that current player hit the ball.
    //println("Doslo je do udarca");
    changeBallSpeed(ball);
  }
}
