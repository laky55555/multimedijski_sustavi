PImage pogled, pogled2;
int number_of_rectangles = 30;
int picture_section_width, picture_section_height;
int picture_section_width2, picture_section_height2;


void setup() {
  size(1024,768,P3D);
  pogled = loadImage("colors2.jpg");
  pogled2 = loadImage("colors1.jpg");

  camera(320,240,800,320,240,0,0,1,0);
  
  picture_section_width = pogled.width/number_of_rectangles;
  picture_section_height = pogled.height;
  
  picture_section_width2 = pogled2.width/number_of_rectangles;
  picture_section_height2 = pogled2.height;


}

void draw() {
  //lights();
  //spotLight(255, 255, 255, 600, 5400, 1000, 0, -1, 0, PI/3, 2);
  background(128);
  pushMatrix();
  
  for(int i=0;i<=number_of_rectangles;++i) {
    rotateY(2*PI/number_of_rectangles);
    image(pogled, 0,0,                         25,picture_section_height, i*picture_section_width, 0,(i+1)*picture_section_width, picture_section_height);
    image(pogled2,0,picture_section_height+100,25,picture_section_height2,i*picture_section_width2,0,(i+1)*picture_section_width2,picture_section_height2);

    translate(25,00);
  }
  popMatrix();
  //camera(70.0, 35.0, 120.0, 50.0, 50.0, 0.0, 0.0, 1.0, 0.0);
  camera(200+mouseX,mouseY*3,40,0,picture_section_height/2,mouseY,-1,1,0);
}