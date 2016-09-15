
void debugger() {
  if (debug) {
    drawCursors();
    drawActivationPoints();
    drawConsole(10, 15);


    noStroke();
    fill(0, 1);
    rectMode(CORNER);
    rect(0, 0, 400, height);

    fill(255);
    textSize(14);
    text(debugText, 10, 20, 360, height-40);
  }
}

// show activation points for testing
void drawActivationPoints() {
  if (debug) {
    rectMode(CENTER);
    fill(0, 10);
    rect(50, 50, 100, 100);
    stroke(255, 0, 0);
    text("debug", width/2, height/2);
  }
}

// show cursor points for testing
void drawCursors() {
  if (debug) {


    ellipseMode(CENTER);
  }
}


//Example code using printConsole
void mousePressed() {

  if (mouseButton == LEFT)
    printConsole("mousePressed. button = left");  
  if (mouseButton == RIGHT)
    printConsole("mousePressed. button = right");  
  if (mouseButton == CENTER)
    printConsole("mousePressed. button = center");
}

void keyReleased() {
  if (key=='d' || key=='D') {
    angle = angle + 180;
    angleSpeed = angleSpeed * -1;
  }
  // r g b alpha
  if (key == ' ') col = color(random(255), random(255), random(255), random(80, 150));

  //default colors from 1 to 4 
  if (key == '1') col = color(181, 157, 0, 100);
  if (key == '2') col = color(0, 130, 164, 100);
  if (key == '3') col = color(87, 35, 129, 100);
  if (key == '4') col = color(197, 0, 123, 100);

  // load svg for line module
  if (key=='5') lineModule = null;
  if (key=='6') lineModule = loadShape("shapes/02.svg");
  if (key=='7') lineModule = loadShape("shapes/03.svg");
  if (key=='8') lineModule = loadShape("shapes/04.svg");
  if (key=='9') lineModule = loadShape("shapes/05.svg");
  if (lineModule != null) {
    lineModule.disableStyle();
  }
}

void keyPressed() {
    if (keyCode == UP) lineModuleSize += 5;
  if (keyCode == DOWN) lineModuleSize -= 5;
  if (keyCode == LEFT) angleSpeed -= 0.5;
  if (keyCode == RIGHT) angleSpeed += 0.5;
}

//Draws the on-screen console
void drawConsole(float x, float y) {
  //Set drawing specifications
  fill(255, 180);
  noStroke();
  textFont(uifont, 12);  
  textAlign(LEFT);

  //move it to x and y positioning
  pushMatrix();
  translate(x, y);

  //the number of pixels per row
  float rowHeight = 15;

  //go through console array and draw the text
  for (int i=0; i<maxLines; i++) {
    if (console[i]!=null) {
      //do some smart detection of \n linebreaks etc
      text(console[i], 0, 0);

      //move to the next line
      translate(0, rowHeight);
    }
  }
  popMatrix();
}


//Prints to on-screen console and to processing console.
void printConsole(String string) {
  //allow us to print to both our own console 
  //and the println() console
  println(string);

  //shift everything down one, remove the last, 
  //and insert string to the first slot

  //a fast way to do this is by making a new array
  String refreshedConsole[] = new String[maxLines];

  //copy the printer string to the first index
  refreshedConsole[0] = string;  

  //copying everything into the new array except the last one
  arraycopy(console, 0, refreshedConsole, 1, maxLines-1);

  //set the pointer for console to our newly refreshed console
  console = refreshedConsole;
}