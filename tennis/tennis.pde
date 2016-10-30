Racket player1;
Racket player2;
Ball ball;

void setup() {
  println(width);
  println(height);
  //fullScreen();
  size(700, 800);
  // 65 and 68 are codes for letters A and D.
  player1 = new Racket(0, 100, "Player1", false, LEFT, RIGHT);
  // 37 and 39 are codes for arrows left and right.
  player2 = new Racket(width/2, height - 100, "Player2", true, 37, 39);
  
  ball = new Ball();

}


void draw() {
  background(255,175,95);
  
  player1.display();
  player2.display();
  ball.display();
  
  player1.strike(ball);
  player2.strike(ball);
  ball.update();
  
}


void keyPressed(){
  player1.checkPressedKey(keyCode);
  player2.checkPressedKey(keyCode);
}