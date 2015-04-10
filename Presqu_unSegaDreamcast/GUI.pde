GUI theGUI;

class GUI {//graphical user interface (CURRENTLY IN TESTING)

  boolean showGUI = true;
  color bgColor = color(200);
  int GUIwidth = width; 
  int GUIheight = height; 

  PImage splash;
  PShape introScreen;

  PGraphics GUIrender;

  GUItext dialogBox;
  GUImenu menuBox;
  GUItext smallBox;

  //is the dialogbox displaying text?
  boolean isDisplayingText;
  //last time text got displayed
  int lastTextTime;
  //angle of rotation for the intro camera
  float rotAngle;

  GUI() {
    dialogBox = new GUItext(0, 250, 400, 80);
    //smallBox = new GUItext(-GUIwidth/2 + 70, -GUIheight/2 + 45, 128, 80, "textboxM.png");
    smallBox = new GUItext(-GUIwidth/2 + 130, -GUIheight/2 + 45, 253, 80, "textTRANS.png");
    menuBox = new GUImenu(0, 250, 400, 80);
    menuBox.setMenu("main");
    splash = loadImage("splash.png");
    //introScreen = loadShape("intro/inside_lowres.obj");
    //introScreen.scale(-1);
    GUIrender = createGraphics (GUIwidth, GUIheight);
  }

  void display() {
    //you can use this to turn off the GUI for screenshots or test 
    if (showGUI) {
      pushMatrix();
      //since we use a camera, the reference point becomes the center of the screen
      translate(GUIpos().x, GUIpos().y, GUIpos().z);
      //draw the menu (images) from the center as reference
      imageMode(CENTER);
      //scale + rotate them according to the camera orientation to keep them 2D
      rotateY(frontPlane());
      scale(0.25);
      //main GUI function
      drawGUIobjects();
      popMatrix();
    }
  }

  //this function holds all the GUI objects and thier logic
  void drawGUIobjects() {
    showInfo();
    checkMenu();
    if (activeMenu() != null) {
      image(menuBox.drawObject(), menuBox.getPosition().x, menuBox.getPosition().y);
    } else {
      image(smallBox.drawObject(), smallBox.getPosition().x, smallBox.getPosition().y);
      image(dialogBox.drawObject(), dialogBox.getPosition().x, dialogBox.getPosition().y);
    }
  }

  //cleans the text box
  void cleanText() {
    dialogBox.clean();
  }

  void showInfo() {
    if (thePlayer.activeMap != null) {
      if (frameCount % 5 == 0) { 
        smallBox.clean();
        smallBox.writeText(thePlayer.activeMap.getMapName(), 0);
        smallBox.writeText(thePlayer.getPosition(), 1);
        smallBox.writeText(thePlayer.activeMap.getObjective(), 2);
      }
    }
  }

  //clean the menubox
  void cleanMenu() {
    menuBox.clean();
  }

  //check which menu to display
  void checkMenu() {
    menuBox.checkMenu();
  }

  //passes info to the dialog box to write text
  void writeText(String input, int yPos) {
    dialogBox.writeText(input, yPos);
  }

  //shows a little loading screen
  void loading() {
    dialogBox.writeText("Loading", 5);
  }

  //gets the currently active menu
  String activeMenu() {
    return menuBox.getActiveMenu();
  }

  //sets the menu mode to something else
  void setMenu(String menuStatus) {
    menuBox.setMenu(menuStatus);
  }

  void setTextState(boolean state) {
    isDisplayingText = state;
    lastTextTime = millis();
  }

  boolean isDisplayingText() {
    return isDisplayingText;
  }


  int noTextSince() {
    return millis() - lastTextTime ;
  }


  //  //shows the intro screen
  //  void showSplash() {
  //    image(splash, 0, -50);
  //  }


  void showIntroScreen() {
    lights();
    rotAngle =+ 0.001;
    thePlayer.rotateCamera(radians(10)*sin(rotAngle));
    shape(introScreen);
  }

  //well... keypresses...  
  void keyPressed() {
    menuBox.keyPressed();
    if (key == 'q') showGUI = !showGUI;
  }

  //puts the GUI in front of the camera object
  PVector GUIpos() { 
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.1);
  }
}

