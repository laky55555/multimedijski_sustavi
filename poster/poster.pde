PShape poster;
PShape titleShort, titleLong1, titleLong2, icon, star1, star2, speakers, camera;
PShape ellipse, test;

int starDimX = 50, starDimY = 50;

void setup() {
  size(800, 600);
  poster = loadShape("plakat.svg");
  titleShort = poster.getChild("naslov_kratki");
  titleLong1 = poster.getChild("naslov_dugi_1");
  titleLong2 = poster.getChild("naslov_dugi_2");
  icon = poster.getChild("ikona");
  star1 = poster.getChild("zvijezda1");
  star2 = poster.getChild("zvijezda2");
  speakers = poster.getChild("pozadina");
  camera = poster.getChild("kamera");
  speakers.disableStyle();

  ellipse = createShape(ELLIPSE, -25, 0, 50, 50);
  ellipse.setVisible(false);

  createTestShape();

  //println("Sirina " + star1.width);
  //println("Visina " + star1.height);
}

void draw() {
  //background(74,206,205);
  background(0);
  shapeMode(CORNER);

  //Kod crtanja pozdainske slike morao sam iskljuciti stil da processing moze uvesit sliku. 
  shape(speakers, 0, 0, width - 15, height - 15);
  //Crtanje kamere nije moguce (vjerojatno jer je png slika uvezena u svg).
  //shape(camera, 0, 0);

  shape(ellipse, 0, 0);
  shape(test, 0, 0);

  shape(titleShort, 0, 0);
  shape(titleLong1, 0, 0);
  shape(titleLong2, 0, 0);

  shape(star1, 0, 0);
  shape(star2, 0, 0);
  
  //Smanjivanje/povecavanje lijeve i mijananje boje desne zvijezde.
  //Nasumicno pojavljivanje rijeci multimedijski i sustavi. 
  if (frameCount % 10 == 0) {
    star1.scale(1.2, 1.2);
    star2.disableStyle();
    star1.setFill(color(random(0, 255), random(0, 255), random(0, 255)));
    star2.setFill(color(random(0, 255), random(0, 255), random(0, 255)));
    titleLong1.setVisible(true);
    titleLong2.setVisible(false);
  } else if (frameCount % 10 == 5) {
    star1.scale(10./12, 10./12);
    star2.enableStyle();
    titleLong2.setVisible(true);
    titleLong1.setVisible(false);
  }

  //Kretanje ikone processinga kuda se i mis krece.
  shape(icon, mouseX-100, mouseY-450);
  icon.rotate(0.1);
}


/**
 * Pritiskom na strelice gore/dolje/lijevo/desno i numpad tipke +/-
 * naslov se mice odgovarajucem smjeru, te se povecava/smanjuje.
 */
void keyPressed() {
  //println(keyCode);
  //Stisnut je plus na numpadu
  if (keyCode == 107)
    titleShort.scale(1.2);
  //Stisnut je minus na numpadu
  if (keyCode == 109)
    titleShort.scale(0.8);
  if (keyCode == LEFT)
    titleShort.translate(-10, 0);
  if (keyCode == RIGHT)
    titleShort.translate(10, 0);
  if (keyCode == UP)
    titleShort.translate(0, -10);
  if (keyCode == DOWN)
    titleShort.translate(0, 10);
}

/**
 * Pritiskom na tipku misa stvara se nova elipsa nasumicne velicine
 * i boje na mjestu gdje se mis nalazi.
 */
void mousePressed() {
  ellipse = createShape(ELLIPSE, mouseX, mouseY, random(65, 238), random(64, 249));
  ellipse.setFill(color(random(0, 255), random(0, 255), random(0, 255)));
}


/**
 * Testiranje izradivanje oblika iz processinga 
 * (primjer preuzet s processing stranice
 *   https://processing.org/reference/PShape_beginContour_.html)
 */
void createTestShape() {
  test = createShape();
  test.beginShape();
  test.noStroke();

  // Exterior part of shape
  test.vertex(50, 550);
  test.vertex(50, 520);
  test.vertex(50, 290);
  test.vertex(100, 370);

  // Interior part of shape
  test.beginContour();
  test.vertex(740, 200);
  test.vertex(740, 500);
  test.vertex(600, 500);
  test.vertex(770, 200);
  test.endContour();

  test.endShape();
  test.setFill(color(random(0, 255), random(0, 255), random(0, 255)));
}