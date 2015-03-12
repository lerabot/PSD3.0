GUI theGUI;

class GUI {//graphical user interface (CURRENTLY IN TESTING)
  PImage textBox;

  color bgColor = color(200, 200);
  final int textSize = 14;  //14 is cute
  final int xTextMargin = 10;
  int GUIwidth = 400; 
  int GUIheight = 80; 

  GUI() {
    textBox = loadImage("textbox.png");
    GUIrender = createGraphics(GUIwidth, GUIheight, P3D);
    GUIrender.beginDraw();
    clean();
    //GUIrender.textFont(theFont, 60);
    GUIrender.textAlign(LEFT, TOP);
    GUIrender.endDraw();
  }

  void display() {
    updateGUI();
    pushMatrix();
    translate(GUIpos().x, GUIpos().y, GUIpos().z);
    rotateY(frontPlane());
    scale(0.25);
    imageMode(CENTER);
    image(GUIrender, 0, 270);
    popMatrix();
  }

  void clean() {
    GUIrender.beginDraw();
    GUIrender.background(0, 0);
    GUIrender.image(textBox,0,0);
    GUIrender.endDraw();
  }

  void updateGUI() {
  }

  void GUIloading() {
    GUIrender.beginDraw();
//    GUIrender.background(bgColor);
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text("Loading", 5, 5);
    GUIrender.endDraw();
  }

  void GUItext(String input) {
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text(input, 5, 5);
    GUIrender.endDraw();
  }

  void GUItext(String input, int yPos) {
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text(input, xTextMargin, yPos);
    GUIrender.endDraw();
  }

  void GUItext(float[] input, String name, int yPos) {
    GUIrender.beginDraw();
    GUIrender.stroke(200);
    GUIrender.strokeWeight(5);
    GUIrender.textSize(15);
    GUIrender.text(name+" : X"+int(input[0])+" Y"+int(input[1])+" Z"+int(input[2]), 5, yPos);
    GUIrender.endDraw();
  }

  //puts the GUI in front of the camera object
  PVector GUIpos() {
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.1);
  }

  //a function to return the "attitude" of the camera, so its angle in the polar coord system
}

