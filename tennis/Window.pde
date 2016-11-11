
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
  Button nextBtn, playBtn, newGameBtn;
  int playerNum;
  String errorMessage;
  Racket[] players;
  Racket player1;
  Racket player2;
  Ball ball;
  Textfield[] commands;
  Textfield names[];
  ColorPicker cp;
  Slider R, G, B;
  int[] colors = new int[] {255, 255, 255, 255};
  boolean firstScreen;        //allow changing background color
  color oldColor;       //remember selected color

  //first we show wellcome screen and get info about game
  Window(ControlP5 _controlP5) {
    wellcome = true;
    play = false;
    end = false;
    controlP5 = _controlP5;
    drawer = new Drawer();
    makeControls();
    drawColorPicker();
  }

   //use radio button to get number of players
  //use text boxes to get player names and racket controls
  //add controls to UI
  void makeControls() {    
    controlP5.setFont(drawer.getControlFont(20));
    drawer.setFont(50, 255);
    playerNumRB = controlP5.addRadioButton("playerNum", width/2 - 20, height/4 + 80)
      .setSize(20, 20);
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
    newGameBtn = controlP5.addButton("NewGame")
                .setValue(0)
                .setPosition(width/2 - 70, height/4+100)
                .setSize(150, 60);
    newGameBtn.setVisible(false);
     firstScreen = true;        
  }
  
    void drawColorPicker(){
      R = controlP5.addSlider("R",0,200,128,20,700,100,10); 
      controlP5.getController("R").setColorForeground(#FC0000);
      G = controlP5.addSlider("G",0,200,128,20,730,100,10); 
      controlP5.getController("G").setColorForeground(#0BFC00); 
      B = controlP5.addSlider("B",0,200,128,20,760,100,10);
      controlP5.getController("B").setColorForeground(#002CFC); 
  }

  //player initialization
  void makePlayersAndBall() {
    //Initialization of players and ball
    //// Ball initialization. 
    ball = new Ball();
    players = new Racket[playerNum];
    for(int i = 0; i < playerNum; ++i)
      players[i] = new Racket(width/2-i*100, 100+(i%2)*(height-250)+5*(i-1)*i, names[i].getText(),false,
                              parseInt(commands[i].getText()), parseInt(commands[i+playerNum].getText()), colors[i]);
  }
  


  void drawCurrentStage() {
    if(firstScreen){
      oldColor = color(R.getValue(), G.getValue(), B.getValue());
      background(oldColor);
    }
    else 
      background(oldColor);
    if (wellcome) {
      drawer.makeText("Tennis", 40, 255, width/2, height/4);
      drawer.makeText("Select number of players and names...", 20, 255, width/2, height/4 + 40);
      drawer.makeText(errorMessage, 20, 0, width/2, height/4 + 400);
      changeColorIfHasFocus();
      if(firstScreen)
        drawer.makeTextLeft("You can change background color...", 20, 255, 10, 670);
      else 
        drawer.makeTextLeft("Select color and pick player...", 20, 255, 10, 670);
    } else if (play) {
      //Draw current positions of all players and ball.
      for(int i=0; i < playerNum; ++i)
        players[i].display();
      ball.display();

      //Check if someone stroke the ball.
      for(int i=0; i < playerNum; ++i)
        players[i].strike(ball);
      
       
      int tmp = ball.update();
      if(tmp >= 0){
        end = true;
        play = !end;
        //tu se sada lako moze naci tko je pobjedio...
      }
      
    }else if(end){
      newGameBtn.setVisible(true);
    }
  }

  
  /**
   *Changes made on screen when Button Next is clicked.
   *If number of players is not selected prints errorMessage.
   *Else draw second screen.
   */
  void controlEvent(ControlEvent theEvent) {
    if (!theEvent.isGroup()) {
      if (theEvent.getController().getName().equals("Next"))  //<>//
        nextButtonClick();
      else if (theEvent.getController().getName() == "Play") //<>//
        playButtonClick();   
      else if(theEvent.getController().getName() == "NewGame") //<>//
        newGameButtonClick();
      
    }
  }
  
  void nextButtonClick(){
    for (int i = 0; i < playerNumRB.getArrayValue().length; ++i)
          if (playerNumRB.getArrayValue()[i] == 1)
            playerNum = i + 2;
        if (playerNum == 0) {
          errorMessage = "Please, select number of players!";
          return;
        }
        else {
          firstScreen = false;
          errorMessage = "";
          commands = new Textfield[playerNum*2];
          names = new Textfield[playerNum];
          drawTextFields();
          removeWellcomeScreen();
          playBtn.setVisible(true);
          playBtn.setPosition(width/2 - 50, height/4+80+ playerNum*60);
        }
  }
  
  void removeWellcomeScreen(){
    nextBtn.remove();
    playerNumRB.remove();
  }
  
  
  void playButtonClick(){
    if(comandsEmpty()){
          errorMessage = "You must type all comands";
          return;
    }
    errorMessage = "";
    for (int i = 0; i < playerNum; ++i)
      names[i].remove();
    for (int i = 0; i < playerNum*2; ++i) 
      commands[i].remove();
    
    play=true;
    wellcome=false;
    makePlayersAndBall();
    controlP5.remove("R");
    controlP5.remove("G");
    controlP5.remove("B");
    playBtn.remove();
  }
  
  void newGameButtonClick(){
    wellcome = true;
    end = false;
    play = false;
    playerNum =0;
    newGameBtn.remove();
    makeControls();
    drawColorPicker();  
  }
  
  void visiblityOfColorPicker(boolean value){
    R.setVisible(value);
    G.setVisible(value);
    B.setVisible(value);
  }
  
  boolean comandsEmpty(){
    for(int i=0; i < playerNum*2; ++i)
      if(commands[i].getText().equals(""))
        return true;
    return false;
  }
  

  
  void drawTextFields(){
    for (int i = 0; i < playerNum; ++i) {
      names[i] = controlP5.addTextfield("Player"+i)
        .setPosition(width/2-200, height/4+80+i*50)
        .setSize(150, 30)
        .setFont(drawer.getControlFont(20));
      names[i].getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
        .getStyle().setPaddingLeft(-10);
      commands[i] = controlP5.addTextfield(i+"L")
        .setPosition(width/2, height/4+80+i*50)
        .setSize(50, 30)
        .setFont(drawer.getControlFont(20));
      commands[i].getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
        .getStyle().setPaddingLeft(-10);
      commands[i+playerNum] = controlP5.addTextfield(i+"R")
        .setPosition(width/2+100, height/4+80+i*50)
        .setSize(50, 30)
        .setFont(drawer.getControlFont(20));
      commands[i+playerNum].getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
        .getStyle().setPaddingLeft(-10);
    }
  }

  void changeColorIfHasFocus(){
    for(int i=0; i < playerNum; ++i)
      if(names[i].isFocus()){
        names[i].setColorBackground(color(R.getValue(), G.getValue(), B.getValue()));
        colors[i] = color(R.getValue(), G.getValue(), B.getValue());
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
      for(int i = 0; i < playerNum; ++i)
        players[i].checkPressedKey(key);
    }
  }

  void checkReleasedKey(int key) {
    int index = textFiledInFocus();
    if (index >= 0) {
      commands[index].setText(""+key);
    }
  }
}