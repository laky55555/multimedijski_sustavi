
/**
 * Class keeps information about screen stages and settings.
 * Stages can be wellcome, play, end.
 * Only one is true drung the game, else false
 *Also keeps UI conrols, and handle events
 */

class Window {

  boolean wellcome;
  boolean play;
  boolean end;
  Drawer drawer;
  ControlP5 controlP5;
  RadioButton playerNumRB;
  Button nextBtn;
  Button playBtn;
  int playerNum;
  String errorMessage;
  Racket[] players;
  Racket player1;
  Racket player2;
  Ball ball;
  Textfield[] commands;
  Textfield names[];

  //first we show wellcome screen and get info about game
  //use radio button to get number of players
  //use text boxes to get player names and racket controls
  Window(ControlP5 _controlP5) {
    wellcome = true;
    play = false;
    end = false;
    controlP5 = _controlP5;
    drawer = new Drawer();
    makeControls();
  }

  //add controls to UI
  void makeControls() {
    controlP5.setFont(drawer.getControlFont(20));
    drawer.setFont(50, 255);
    playerNumRB = controlP5.addRadioButton("playerNum", width/2 - 20, height/4 + 80)
      .setSize(20, 20);
    playerNumRB.addItem("1", 1);
    playerNumRB.addItem("2", 2);
    playerNumRB.addItem("3", 3);
    playerNumRB.addItem("4", 4);
    nextBtn = controlP5.addButton("Next")
      .setValue(0)
      .setPosition(width/2 - 50, height/4+200)
      .setSize(100, 50);
    playBtn = controlP5.addButton("Play")
      .setValue(0)
      .setSize(100, 50);
    playBtn.setVisible(false);
    playerNum = 0;
    errorMessage = "";
  }

  //player initialization
  void makePlayersAndBall() {
    //Initialization of players and ball.

    //// 65 and 68 are codes for letters A and D.
    //player1 = new Racket(width/2, 100, "Player1", false, LEFT, RIGHT);
    //// 37 and 39 are codes for arrows left and right.
    //player2 = new Racket(width/2, height - 100, "Player2", true, 37, 39);
    //// Ball initialization. 
    //ball = new Ball();
    players = new Racket[playerNum];
    for(int i = 0; i < playerNum && i < 2; ++i)
      players[i] = new Racket(width/2, 100+i*(height-200), names[i].getText(),false,
                              parseInt(commands[i].getText()), parseInt(commands[i+playerNum].getText()));
  }


  void drawCurrentStage() {
    background(255, 175, 95);
    if (wellcome) {
      drawer.makeText("Tennis", 40, 255, width/2, height/4);
      drawer.makeText("Select number of players and names...", 20, 255, width/2, height/4 + 40);
      drawer.makeText(errorMessage, 20, 0, width/2, height/4 + 300);
    } else if (play) {
      //Draw current positions of all players and ball.
      for(int i=0; i < playerNum; ++i)
        players[i].display();
      ball.display();

      //Check if someone stroke the ball.
      for(int i=0; i < playerNum; ++i)
        players[i].strike(ball);
      
      ball.update();
    }
  }


  /**
   *Changes made on screen when Button Next is clicked.
   *If number of players is not selected prints errorMessage.
   *Else draw second screen.
   */
  void controlEvent(ControlEvent theEvent) {
    if (!theEvent.isGroup()) {
      if (theEvent.getController().getName() == "Next") {
        for (int i = 0; i < playerNumRB.getArrayValue().length; ++i)
          if (playerNumRB.getArrayValue()[i] == 1)
            playerNum = i + 1;
        if (playerNum == 0) {
          errorMessage = "Please, select number of players!";
          return;
        }
        else {
          errorMessage = "";
          commands = new Textfield[playerNum*2];
          names = new Textfield[playerNum];
          
          controlP5.remove("Next");
          controlP5.remove("playerNum");
          drawTextFields();
          playBtn.setVisible(true);
          playBtn.setPosition(width/2 - 50, height/4+80+ playerNum*70);
        }
      } 
      else if (theEvent.getController().getName() == "Play") {
        for (int i = 0; i < playerNum; ++i)
          controlP5.remove("Player"+i);
        for (int i = 0; i < playerNum * 2; ++i) {
          controlP5.remove(i+"L");
          controlP5.remove(i+"R");
        }
        controlP5.remove("Play");
        play=true;
        wellcome=false;
        makePlayersAndBall();
      }
    }
  }
  
  void drawTextFields(){
    for (int i = 0; i < playerNum; ++i) {
      names[i] = controlP5.addTextfield("Player"+i)
        .setPosition(width/2-100, height/4+80+i*50)
        .setSize(150, 30)
        .setFont(drawer.getControlFont(20));
      names[i].getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
        .getStyle().setPaddingLeft(-10);
      commands[i] = controlP5.addTextfield(i+"L")
        .setPosition(width/2+100, height/4+80+i*50)
        .setSize(50, 30)
        .setFont(drawer.getControlFont(20));
      commands[i].getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
        .getStyle().setPaddingLeft(-10);
      commands[i+playerNum] = controlP5.addTextfield(i+"R")
        .setPosition(width/2+190, height/4+80+i*50)
        .setSize(50, 30)
        .setFont(drawer.getControlFont(20));
      commands[i+playerNum].getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
        .getStyle().setPaddingLeft(-10);
    }
  }

  int textFiledInFocus() {
    for (int i = 0; i < playerNum*2; ++i)
      if (commands[i].isFocus())
        return i;
    return -1;
  }
  void checkPressedKey(int key) {
    if (play) {
      player1.checkPressedKey(key);
      player2.checkPressedKey(key);
      return;
    }
  }

  void checkReleasedKey(int key) {
    int index = textFiledInFocus();
    if (index >= 0) {
      commands[index].setText(""+key);
    }
  }
}