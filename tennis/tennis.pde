import controlP5.*;

//Max distance from the end of screen for initializing elements.
int distanceFromEnd = 100;

Window window;
//used for GUI controls
ControlP5 controlP5;


//Game can play 2, 3 or 4 players.

void setup() {
  
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
  window.controlEvent(theEvent);
}

  
/**
 *  Function that check for each player if she want 
 *  to move left or right.
 */
void keyPressed(int key){
  window.checkPressedKey(key);
}