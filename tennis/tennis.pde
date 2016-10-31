//Max distance from the end of screen for initializing elements.
int distanceFromEnd = 100;

//Game can play 2, 3 or 4 players.
Racket player1;
Racket player2;
Racket player3;
Racket player4;

//One ball for playing.
Ball ball;

void setup() {
  
  //Decide between screen size.
  //fullScreen();
  size(700, 800);

  //Initialization of players and ball.
  
  // 65 and 68 are codes for letters A and D.
  player1 = new Racket(width/2, 100, "Player1", false, LEFT, RIGHT);
  // 37 and 39 are codes for arrows left and right.
  player2 = new Racket(width/2, height - 100, "Player2", true, 37, 39);
  // Ball initialization. 
  ball = new Ball();

}


void draw() {
  background(255,175,95);
  
  //Draw current positions of all players and ball.
  player1.display();
  player2.display();
  ball.display();
  
  //Check if someone stroke the ball.
  player1.strike(ball);
  player2.strike(ball);
  ball.update();
  
}


/**
 *  Function that check for each player if she want 
 *  to move left or right.
 */
void keyPressed(){
  player1.checkPressedKey(keyCode);
  player2.checkPressedKey(keyCode);
}