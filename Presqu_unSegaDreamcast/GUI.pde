GUI theGUI;

class GUI {//graphical user interface (CURRENTLY IN TESTING)
  PImage textBox;
  boolean showGUI = true;
  color bgColor = color(200);
  final int textSize = 14;  //14 is cute
  final int xTextMargin = 10;
  final int yTextMargin = 15;
  final int yOffset = 7;
  int GUIwidth = 400; 
  int GUIheight = 80; 
  int menuSelection;
  String activeMenu;
  PImage splash;

  GUI() {
    textBox = loadImage("textbox.png");
    splash = loadImage("splash.png");
    GUIrender = createGraphics(GUIwidth, GUIheight, P3D);
    GUIrender.beginDraw();
    GUIrender.image(textBox, 0, 0);
    //    GUIrender.textFont(theFont, 60);
    GUIrender.textAlign(LEFT, TOP);
    GUIrender.endDraw();
    activeMenu = "main";
  }

  void display() {
    if (showGUI) {
      pushMatrix();
      if (thePlayer.activeMap != null) {
        translate(GUIpos().x, GUIpos().y, GUIpos().z);
        PVector subb = PVector.sub(GUIpos(), thePlayer.getPosition());
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
  }

  void clean() {
    GUIrender.beginDraw();
    GUIrender.image(textBox, 0, 0);
    GUIrender.endDraw();
  }

  void loading() {
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text("Loading", 5, 5);
    GUIrender.endDraw();
  }

  void writeText(String input) {
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text(input, 5, 5);
    GUIrender.endDraw();
  }

  void writeText(String input, int yPos) {
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text(input, xTextMargin, yOffset+(yTextMargin*yPos));
    GUIrender.endDraw();
  }

  void writeText(float[] input, String name, int yPos) {
    GUIrender.beginDraw();
    GUIrender.stroke(200);
    GUIrender.strokeWeight(5);
    GUIrender.textSize(15);
    GUIrender.text(name+" : X"+int(input[0])+" Y"+int(input[1])+" Z"+int(input[2]), 5, yPos);
    GUIrender.endDraw();
  }

  void checkMenu() {
    if (activeMenu != null ) {
      if (activeMenu == "map")
        mapMenu();
      if (activeMenu == "main")
        mainMenu();
      if (activeMenu == "pause")
        pauseMenu();
    }
  }

  void mainMenu() {
    menuSelection = constrain(menuSelection, 0, 2);
    clean();
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text("     Start", xTextMargin, yOffset+(yTextMargin*0));
    GUIrender.text("     Exit", xTextMargin, yOffset+(yTextMargin*1));
    GUIrender.text("     Debug", xTextMargin, yOffset+(yTextMargin*2));
    GUIrender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    GUIrender.endDraw();
    if (menuSelection == 0 && key == 'd' && keyReady) {
      activeMenu = "map";
      clean();
    }
    if (menuSelection == 1 && key == 'd' && keyReady) {
      exit();
    }
    if (menuSelection == 2 && key == 'd' && keyReady) {
      activeMenu = "map";
      debug = true;
      clean();
    }
    keyReady = false;
  }

  void pauseMenu() {
    menuSelection = constrain(menuSelection, 0, 2);
    clean();
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text("     Re-Start", xTextMargin, yOffset+(yTextMargin*0));
    GUIrender.text("     Exit", xTextMargin, yOffset+(yTextMargin*1));
    GUIrender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    GUIrender.endDraw();
    if (menuSelection == 0 && key == 'd' && keyReady) {
      activeMenu = "map";
      clean();
    }
    if (menuSelection == 1 && key == 'd' && keyReady) {
      exit();
    }
    keyReady = false;
  }

  void mapMenu () {
    menuSelection = constrain(menuSelection, 0, 3);
    clean();
    GUIrender.beginDraw();
    GUIrender.fill(0);
    GUIrender.textSize(textSize);
    GUIrender.text("     Garage", xTextMargin, yOffset+(yTextMargin*0));
    GUIrender.text("     Exterieur", xTextMargin, yOffset+(yTextMargin*1));
    GUIrender.text("     Gourdi", xTextMargin, yOffset+(yTextMargin*2));
    GUIrender.text("     Flush", xTextMargin, yOffset+(yTextMargin*3));
    GUIrender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    GUIrender.endDraw();
    //garage
    if (menuSelection == 0 && key == 'd' && keyReady) {
      clean();
      thePlayer.activeMap = new Map(-30, "Garage");
      activeMenu = null;
    }
    //ext
    if (menuSelection == 1 && key == 'd' && keyReady) {
      clean();
      thePlayer.activeMap = new Map(-3, "Ext");
      activeMenu = null;
    }
    //gourdi
    if (menuSelection == 2 && key == 'd' && keyReady) {
      clean();
      thePlayer.activeMap = new Map(-1, "Gourdi");
      activeMenu = null;
    }
    if (menuSelection == 3 && key == 'd' && keyReady) {
      clean();
      thePlayer.activeMap = null;
    }

    keyReady = false;
  }

  void showSplash() {

    image(splash, 0, -50);
  }

  void checkKeypress() {
    if (key == 'o') showGUI = !showGUI;
    if (key == 'a');    //A
    if (key == 'd');     //D
    if (key == 'w') menuSelection -= 1;           //W
    if (key == 's') menuSelection += 1;        //S
  }

  //puts the GUI in front of the camera object
  PVector GUIpos() {
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.1);
  }
}

