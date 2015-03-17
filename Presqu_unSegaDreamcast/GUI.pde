GUI theGUI;

class GUI {//graphical user interface (CURRENTLY IN TESTING)
  PImage textBox;

  color bgColor = color(200);
  final int textSize = 14;  //14 is cute
  final int xTextMargin = 10;
  final int yTextMargin = 15;
  final int yOffset = 7;
  int GUIwidth = 400; 
  int GUIheight = 80; 
  int menuSelection;
  String activeMenu;

  GUI() {
    textBox = loadImage("textbox.png");
    GUIrender = createGraphics(GUIwidth, GUIheight, P3D);
    GUIrender.beginDraw();
    GUIrender.image(textBox, 0, 0);
    //    GUIrender.textFont(theFont, 60);
    GUIrender.textAlign(LEFT, TOP);
    GUIrender.endDraw();
  }

  void display() {
    pushMatrix();
    if (thePlayer.activeMap != null) {
      translate(GUIpos().x, GUIpos().y, GUIpos().z);
      PVector subb = PVector.sub(GUIpos(), thePlayer.getPosition());
      println(subb.mag());
      scale(0.25);
    } else {
      translate(0, 0, 0);
      scale(1);
    }
    rotateY(frontPlane());
    imageMode(CENTER);
    image(GUIrender, 0, 270);
    popMatrix();
  }

  void clean() {
    GUIrender.beginDraw();
    GUIrender.image(textBox, 0, 0);
    GUIrender.endDraw();
  }

  void updateGUI() {
  }

  void GUIloading() {
    GUIrender.beginDraw();
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
    GUIrender.text(input, xTextMargin, yOffset+(yTextMargin*yPos));
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

  void GUImenu() {
    activeMenu = "main";
    menuSelection = constrain(menuSelection, 0, 1);
    clean();
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text("     Start", xTextMargin, yOffset+(yTextMargin*0));
    GUIrender.text("     Exit", xTextMargin, yOffset+(yTextMargin*1));
    GUIrender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    GUIrender.endDraw();
    if (menuSelection == 0 && key == 100) {
      clean();
      myPapiGarage = new Map(-30, "Garage");
    }
    if (menuSelection == 1 && key == 100) {
      exit();
    }
  }

  void checkKeypress() {
    if (key == 97);    //A
    if (key == 100);     //D
    if (key == 119) menuSelection -= 1;           //W
    if (key == 115) menuSelection += 1;        //S
  }

  //puts the GUI in front of the camera object
  PVector GUIpos() {
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.1);
  }
}

