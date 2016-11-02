//int distanceFromEnd = 200;
float maxBallSpeed = 5;

/**
 * Class representing ball.
 * Class is responsible for displaying and moving ball
 * throughout the game.
 */
class Ball{
  // Default starting position width.
  int x_coord = width/2;
  // Default starting position height.
  int y_coord = height/2;
  // Default starting size width.
  int x_size = 20;
  // Default starting size height.
  int y_size = 20;
  // Default starting speed across width.
  float speed_x = 1;
  // Default starting speed across height.
  float speed_y = 3;
  // Default starting filling color.
  color fill_color = color(255);


  /**
   * Default constructor. Construct Ball with default values.
   */
  Ball() {
  }


  /**
   * Detailed constructor that construct Ball instance with all parameter
   * like given in argument list.
   * @param x_coor    Starting width position, must be between 0 and screen width.
   * @param y_coor    Starting height position, must be between 0 and screen height.
   * @param x_siz     Starting size width, must be between 2 and 50.
   * @param y_siz     Starting size height, must be between 2 and 50.
   * @param speed_xx  Starting speed across width, best between -5 and 5.
   * @param speed_yy  Starting speed across height, best between -5 and 5.
   * @param fill_colo Ball filling color.
   */
  Ball(int x_coor, int y_coor, int x_siz, int y_siz, float speed_xx, float speed_yy, color fill_colo) {

    x_coord = x_coor;
    if(x_coord < 0 || x_coord > width)
        x_coord = width/2;

    y_coord = y_coor;
    if(y_coord < distanceFromEnd || y_coord > height - distanceFromEnd)
        y_coord = height/2;

    x_size = x_siz;
    if(x_size < 2 || x_size > 50)
        x_size = 20;

    y_size = y_siz;
    if(y_size < 2 || y_size > 50)
        y_size = 20;

    speed_x = speed_xx;
    speed_x = speed_yy;
    fill_color = fill_colo;
  }

  /**
   * Function for drawing current position of ball on screen.
   */
  void display() {
    fill(fill_color);
    stroke(0);
    //ellipseMode(CENTER);
    ellipse(x_coord, y_coord, x_size, y_size);
    //println(x_coord + "  TUSAM  " + y_coord);
  }

  /**
   * Getter for width coordinate.
   * @return Returns int of width coordinate.
   */
  int getPosX() {
    return x_coord;
  }

  /**
   * Getter for height coordinate.
   * @return Returns int of height coordinate.
   */
  int getPosY() {
    return y_coord;
  }

  /**
   * Getter for width size.
   * @return Returns width of the ball.
   */
  int getSizeX() {
    return x_size;
  }

  /**
   * Getter for ball speed across width.
   * @return Ball speed across width.
   */
  float getSpeedX() {
    return speed_x;
  }

  /**
   * Getter for ball speed across height.
   * @return Ball speed across height.
   */
  float getSpeedY() {
    return speed_y;
  }

  /**
   * Setter for ball speed across width.
   * @param newSpeedY float of new ball speed across width.
   */
  void setSpeedX(float newSpeedX) {
    if(newSpeedX >= -15 && newSpeedX < 15)
      speed_x = newSpeedX;
  }

  /**
   * Setter for ball speed across height.
   * @param newSpeedY float of new ball speed across height.
   */
  void setSpeedY(float newSpeedY) {
    if(newSpeedY >= -15 && newSpeedY < 15) {
      speed_y = newSpeedY;
      //println("Nova y brzina " + speed_y);
    }
  }


  /**
   * Function make/update current ball position.
   * Function is responsible for checking if ball hit wall,
   * or if game is over.
   */
  boolean update() {
    y_coord += speed_y;

    //If y coordinate are outside screen someone lost.
    if(y_coord <= 0 || y_coord >= height)
       return true;

    //If x coordinate are outside screen ball should hit the wall.
    if(speed_x < 0 && x_coord + speed_x < 0)
      x_coord = 0;
    else if(speed_x > 0 && x_coord + speed_x + x_size > width)
       x_coord = width - x_size;
    else
      x_coord += speed_x;

    //We use width - x_size because we need to calculate for width of the ball.
    if(x_coord == 0 || x_coord == width - x_size)
      hitWall();
    return false;
  }


  /**
   * Function that decide in which direction should ball go
   * after it hit the wall.
   */
  void hitWall() {
    //println("TTTUU" + speed_y);

    //After ball hit the wall it will go in random different direction.
    if(speed_x < 0)
      speed_x = random(2,5);
    else
      speed_x = -random(2,5);


    //Speed stays unchanged.

    //println("Nova x brzina je " + speed_x +  "koordinate su " + x_coord + ", " + y_coord);
  }

  /**
   * Function that is called only after game is finished and someone lost.
   */
  void gameOver() {
    println("Pao je gol");
    exit();
  }


}