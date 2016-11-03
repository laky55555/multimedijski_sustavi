import controlP5.*;

//Max distance from the end of screen for initializing elements.
int distanceFromEnd = 100;

Window window;
//used for GUI controls
ControlP5 controlP5;


//Game can play 2, 3 or 4 players.

void setup() {
  
  frameRate(80);
  //Decide between screen size.
  //fullScreen();
  size(700, 800);
  
  controlP5 = new ControlP5(this);
  window = new Window(controlP5);
  
}


void draw() {
  window.drawCurrentStage();

}

//reply to event
void controlEvent(ControlEvent theEvent){
  println("cotrolevet");
  window.controlEvent(theEvent);
}

  
/**
 *  Function that check for each player if she want 
 *  to move left or right.
 */
void keyPressed(){
  window.checkPressedKey(keyCode);
}


void keyReleased(){
  window.checkReleasedKey(keyCode);
  
}