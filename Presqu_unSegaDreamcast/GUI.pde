GUI theGUI;

class GUI {//graphical user interface (CURRENTLY IN TESTING)

  boolean showGUI = true;
  color bgColor = color(200);
  int GUIwidth = width; 
  int GUIheight = height; 

  PImage splash;

  PGraphics GUIrender;

  GUItext dialogBox;
  GUImenu menuBox;

  GUI() {
    dialogBox = new GUItext(0, 250, 400, 80);
    menuBox = new GUImenu(0, 250, 400, 80);
    menuBox.setMenu("main");
    splash = loadImage("splash.png");
    GUIrender = createGraphics (GUIwidth, GUIheight);
  }

  void display() {
    if (showGUI) {

      pushMatrix();

      if (thePlayer.activeMap != null) {
        translate(GUIpos().x, GUIpos().y, GUIpos().z);
        scale(0.25);
      } else {
        translate(0, 0, 0);
        scale(1);
      }
      imageMode(CENTER);
      rotateY(frontPlane());
      GUIrender.beginDraw();
      if (activeMenu() != null) {
        image(menuBox.drawObject(), 0, 250);
      } else {
        image(dialogBox.drawObject(), 0, 250);
      }
      GUIrender.endDraw();
      //      image(GUIrender, -width/2, -height/2);
      popMatrix();
    }
  }

  void cleanText() {
    dialogBox.clean();
  }

  void cleanMenu() {
    menuBox.clean();
  }

  void checkMenu() {
    menuBox.checkMenu();
  }

  void writeText(String input, int yPos) {
    dialogBox.writeText(input, yPos);
  }

  void loading() {
    dialogBox.writeText("Loading", 5);
  }

  String activeMenu() {
    return menuBox.getActiveMenu();
  }

  void setMenu(String menuStatus) {
    menuBox.setMenu(menuStatus);
  }


  void showSplash() {
    image(splash, 0, -50);
  }

  void keyPressed() {
    menuBox.keyPressed();
    if (key == 'q') showGUI = !showGUI;
  }



  //puts the GUI in front of the camera object
  PVector GUIpos() { 
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.1);
  }
}

