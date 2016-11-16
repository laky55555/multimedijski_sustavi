PrintWriter output;
int stariX, stariY;
int noviX, noviY;

void setup() {
  fullScreen();
  stariX = -1;
  stariY = -1;
  noviX = -1;
  noviY = -1;
  stroke(255,0,0);
  frameRate(30);
  output = createWriter("./izlaz/ivan.txt"); 
}

void draw () {
if (mousePressed ) {
  noviX = mouseX; noviY = mouseY;
  if (stariX != -1) {
      stroke(255,0,0);
      line(stariX,stariY,noviX,noviY);
      println(stariX,stariY,noviX,noviY,millis());
      output.println(stariX+"\t"+stariY+"\t"+noviX+"\t"+noviY+"\t"+millis());
  }
  stariX = noviX; stariY = noviY;
  // background(255,255,255);   
} else {
  // background(250,250,250);
  stariX = -1; stariY = -1;
}
line(30, 20, 85, 20);
}

void keyPressed() {
  output.flush(); // Ispiše preostale podatke u datoteku
  output.close(); // Zatvara datoteku
  saveFrame("potpis5.png");
  exit(); // Izlazak iz programa
}