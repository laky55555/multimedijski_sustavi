import controlP5.*;
import processing.net.*;
import java.net.InetAddress;

ControlP5 controlP5;
Button playBtn, newGameBtn;

int racketX1, racketY1;
int racketX2, racketY2;
int ballX, ballY;

Client c;
String ipAddr;
boolean playScreen;
String input;
PFont font;

void setup(){
  frameRate(40);
  frameRate(20);
  size(800, 800);
  controlP5 = new ControlP5(this);
  addControls();
  playBtn.setVisible(true);       
  font = createFont("Arial",20,true);
}

void addControls(){
  playBtn = controlP5.addButton("Play")
                     .setPosition(width/2 - 50, height/2-25)  
                     .setSize(100, 50)
                     .setVisible(false);
  newGameBtn = controlP5.addButton("NewGame")
                     .setPosition(width/2 - 50, height/2-25)  
                     .setSize(100, 50)
                     .setVisible(false);
}

void draw(){
  
  if(playScreen){
    background(255, 153, 255);  
    if(frameCount % 5 == 0){
      String data = Integer.toString(mouseX) + "\n";
      //println(data);
      c.write(data);
    }
    if(c.available() > 0){
      input = c.readString();
      println(input);
      String[] playerData = split(input, '\n');
      println(playerData[0]);
      if(!playerData[0].equals("")){
        String[] coordinatesAndIp = split(playerData[0], ' ');
        if(coordinatesAndIp.length == 6){
          rect(Float.parseFloat(coordinatesAndIp[0]), Float.parseFloat(coordinatesAndIp[1]), 100, 20, 7);
          rect(Float.parseFloat(coordinatesAndIp[2]), Float.parseFloat(coordinatesAndIp[3]), 100, 20, 7);
          ellipse(Float.parseFloat(coordinatesAndIp[4]), Float.parseFloat(coordinatesAndIp[5]), 20, 20);
        }
      }
      for(int i = 0; i < playerData.length; ++i){
        String[] findEnd = split(playerData[i], ' ');  
        if(findEnd.length == 1 && findEnd[0].equals("END")){
          background(255, 153, 255);  
          playScreen = false;
          playBtn.setVisible(true);
        }
      } 
    }
    else{
      textAlign(CENTER);
      fill(color(152, 0, 153));
      textFont(font,25);
      text("Wait for Laky55555 server...", width/2, height/2);
    }  
  }
}

void controlEvent(ControlEvent theEvent){
  if (theEvent.getController().getName().equals("Play")) 
    playButtonClick();
  
  
}

void playButtonClick(){
  println("stvaram novog klijenta");
  c = new Client(this, "192.168.137.11", 12345);
  InetAddress inet;
  try {
      inet = InetAddress.getLocalHost();
      ipAddr = inet.getHostAddress();
      println(ipAddr);
      println(inet);
      println(c.ip());
  } catch (Exception e) {
    e.printStackTrace();
  }
  playBtn.setVisible(false);
  playBtn.hide();
  playScreen = true;
  c.write("play");
}