import processing.net.*;
import java.net.InetAddress;

int distanceFromEnd = 100;

String ipAddr;
String clientsIPs[];
int numberOfClients;

Server s;
Client c;
String input;
String datas[];
String pozicije[];
boolean started;
Ball ball;
Racket rackets[];

void setup() 
{
  
  size(1024, 1024);
  background(204);
  stroke(0);
  frameRate(60);
  s = new Server(this, 12345); // Start a simple server on a port
  InetAddress inet;
  try {
   inet = InetAddress.getLocalHost();
   println("SERVER:" + inet);
   println("SERVER:" + inet.getHostAddress());
  ipAddr = inet.getHostAddress();
  println("SERVER:" + ipAddr);
  } catch (Exception e) {
   e.printStackTrace();
  }
  
  clientsIPs = new String[2];
  numberOfClients = 0;
  started = false;
}

void waitForClients() {
  c = s.available();
  if (c != null && isClient(c) == -1 && c.ip() != null) {
    input = c.readString();
    println("SERVER:" + "Client ip = " + c.ip());
    println("SERVER:" + "Input data = " + input);
    println("SERVER:" + "Number of clients so far: " + numberOfClients);
    
    // check if we got just one message from client
    String messages[] = split(input, '\n');
    //if(messages.length != 1)
      //return;
    
    // check what message we got from client
    String message[] = split(messages[0], ' ');
    if(message.length != 1 && !message[0].equalsIgnoreCase("play"))
      return;
      
    // check if we already have this client
    for(int i=0; i<numberOfClients; i++)
      if(clientsIPs[i].equals(c.ip()))
        return;
        
    // new client
    clientsIPs[numberOfClients++] = c.ip();
    println("SERVER:" + "NUMBER OF CLIENTS = " + numberOfClients);
  }
}

int isClient(Client client) {
  if(client == null)
    return -1;
  
  for (int i=0; i<numberOfClients; i++)
    if(clientsIPs[i].equals(client.ip()))
      return i;
      
  return -1;
}

void getNewInfo() {
  c = s.available();
  int player = isClient(c);
  if (player != -1) {
    
    input = c.readString();
    println("SERVER:" + "Client ip = " + c.ip() + " client number = " + player);
    println("SERVER:" + "Input data = " + input);
    
    String messages[] = split(input, '\n');
    
    int xCoord[] = int(split(messages[0], ' '));
    if(xCoord.length != 1)
      return;
      
    rackets[player].x_coord = xCoord[0];
  }
}


void sendUpdateInfo() {
  
  String data = "";
  for(int i=0; i<numberOfClients; i++)
    data += rackets[i].x_coord + " " + rackets[i].y_coord + " ";
  data += ball.getPosX() + " " + ball.getPosY() + "\n";
  //println("SERVER:" + "SALJEM: (u novom redu)");
  //println("SERVER:" + data);
  s.write(data);

}

void gameOver() {
  println("SERVER:" + "Saljem end");
  String end = "END" + "\n";
  s.write(end);
  numberOfClients = 0; 
  started = false;
}

void initializeNewGame() {
  ball = new Ball();
  int dodatak = 0;
  rackets = new Racket[numberOfClients];
  for(int i=0; i<numberOfClients; i++) {
    if(i >= 2)
      dodatak = 50; 
    rackets[i] = new Racket(width/2-i*100, 100+(i%2)*(height-250) + dodatak, "Player" + i, false, 2, 2, 0);
  } 
  started = true;
  println("SERVER:" + "KRECEMo");
}

void draw() 
{
  fill(0);
  rect(720,580,80,20);
  fill(255,255,0,255);
  text(frameRate,720,600);
  
  if(numberOfClients != 2)
    waitForClients();
  else if(started == false) {
    println("SERVER:" + "started == false");
    initializeNewGame();
  }
  else {
    
    getNewInfo();
    // if condition is true someone lost
    for(int i=0; i<numberOfClients; i++)
      rackets[i].strike(ball);
    
    if(ball.update() >= 0) {
      gameOver();
      return;  
    }
    sendUpdateInfo();  
  }
}