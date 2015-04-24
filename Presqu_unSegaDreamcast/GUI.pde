GUI theGUI;

class GUI {//graphical user interface (CURRENTLY IN TESTING)

  //flag to show or not the GUI on screen
  boolean showGUI = true;
  //size of the GUI
  final int GUI_WIDTH = width; 
  final int GUI_HEIGHT = height; 

  //this is the logo of the game
  PImage splash;
  PImage loadingScreen;
  //the 3d models for the intro screen
  PShape introScreen;

  //this is the pGraphics that holds all the GUI visual
  PGraphics GUIrender;

  //list of GUI object to be displayed by the GUI
  GUItext dialogBox;
  GUImenu menuBox;
  GUItext smallBox;

  //is the dialogbox displaying text?
  boolean isDisplayingText;
  //last time text got displayed
  int lastTextTime;
  //angle of rotation for the intro camera
  float rotAngle;
  //the name (ID) of thdisplay()e currenct text displayed
  String currentTextName;

  //a reference to the last displayed lcdText object
  lcdText currentText;

  GUI() {
    //adds different GUI object over the screen
    dialogBox = new GUItext(0, 250, 400, 80);
    menuBox = new GUImenu(0, 250, 400, 80);
    //sets the current menu to the "main" menu
    menuBox.setMenu("main");
    smallBox = new GUItext(-GUI_WIDTH/2, -GUI_HEIGHT/2, 253, 80, "textTRANS.png");
    //loads the slash Screen image
    splash = loadImage("splash.png");
    loadingScreen = loadImage("loading.png");
    //loads the intro 3d model and scales it
    introScreen = loadShape("intro/inside_lowres.obj");
    introScreen.scale(-1);
    //create the PGraphics where everything is going to be drawn.
    GUIrender = createGraphics (GUI_WIDTH, GUI_HEIGHT);
  }

  GUI(GameController controller) {
    //adds different GUI object over the screen
    dialogBox = new GUItext(0, 250, 400, 80);
    menuBox = new GUImenu(0, 250, 400, 80, controller);
    //sets the current menu to the "main" menu
    menuBox.setMenu("main");
    smallBox = new GUItext(-GUI_WIDTH/2, -GUI_HEIGHT/2, 253, 80, "textTRANS.png");
    //loads the slash Screen image
    splash = loadImage("splash.png");
    loadingScreen = loadImage("loading.png");
    //loads the intro 3d model and scales it
    introScreen = loadShape("intro/inside_lowres.obj");
    introScreen.scale(-1);
    //create the PGraphics where everything is going to be drawn.
    GUIrender = createGraphics (GUI_WIDTH, GUI_HEIGHT);
  }

  void display() {
    //shuts the lights if there's light, so the 2D elements are not affected by it.
    noLights();
    //you can use this to turn off the GUI for screenshots or test 
    if (showGUI) {
      pushMatrix();
      //since we use a camera, the reference point becomes the center of the screen
      translate(GUIpos().x, GUIpos().y, GUIpos().z);
      //draw the menu (images) from the center as reference
      imageMode(CENTER);
      //scale + rotate them according to the camera orientation to keep them 2D
      rotateY(frontPlane()[0]);
      rotateZ(frontPlane()[2]);
      rotateX(-frontPlane()[1]);
      scale(0.25);
      //main GUI drawing function
      drawGUIobjects();
      popMatrix();
    }
  }

  //this function holds all the GUI objects and thier logic
  void drawGUIobjects() {
    //updates the small info box top left
    updatesInfoBox();
    //check which menu is active
    checkMenu();
    //is there's no active menu, draws the GUI elements
    if (activeMenu() != null) {
      image(menuBox.drawObject(), menuBox.getPosition().x, menuBox.getPosition().y);
    } else {
      image(dialogBox.drawObject(), dialogBox.getPosition().x, dialogBox.getPosition().y);
      imageMode(CORNER);
      image(smallBox.drawObject(), smallBox.getPosition().x, smallBox.getPosition().y);
    }
  }

  //cleans the text box
  void cleanText() {
    dialogBox.clean();
  }

  //updates the info box with player position and other infos
  void updatesInfoBox() {
    if (thePlayer.activeMap != null) {
      if (frameCount % 5 == 0) { 
        smallBox.clean();
        //writes the current map name
        smallBox.writeText(thePlayer.activeMap.getMapName(), 0);
        //write the player position
        smallBox.writeText(thePlayer.getPosition(), 1);
        //writes the maps objective
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
    cleanText();
    pushMatrix();
    //since we use a camera, the reference point becomes the center of the screen
    translate(GUIpos().x, GUIpos().y, GUIpos().z);
    //draw the menu (images) from the center as reference
    //scale + rotate them according to the camera orientation to keep them 2D
    rotateY(frontPlane()[0]);
    rotateZ(frontPlane()[2]);
    rotateX(-frontPlane()[1]);
    scale(0.25);
    imageMode(CENTER);
    image(loadingScreen, 0, 0);
    popMatrix();
  }

  //gets the currently active menu
  String activeMenu() {
    return menuBox.getActiveMenu();
  }

  //sets the menu mode to something else
  void setMenu(String menuStatus) {
    menuBox.setMenu(menuStatus);
  }

  //keeps track of if the GUI is displaying text, and which one
  void setTextState(boolean state, lcdText thisText) {
    isDisplayingText = state;
    if (state)
      lastTextTime = millis();
    currentText = thisText;
  }

  //return the last text object displayed
  lcdText getCurrentText() {
    return currentText;
  }

  //returns the current state of the GUI, if it's displayng text of nor
  boolean isDisplayingText() {
    return isDisplayingText;
  }

  //keeps tracks of the last time a text has been displayed
  int noTextSince() {
    return millis() - lastTextTime ;
  }


  //  //shows the intro screen
  //  void showSplash() {
  //    image(splash, 0, -50);
  //  }

  //I don't know if this is really a GUI thing, but shows the 3D model of the intro screen
  void showIntroScreen() {
    lights();
    rotAngle =+ 0.01;
    thePlayer.rotateCamera(radians(10)*sin(rotAngle));
    shape(introScreen);
  }

  //check for controller changes and calls every GUI object which use them
  void checkController() {
    menuBox.checkController();
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

