class GUImenu extends GUItext {

  //keeps track fo where the arrow is in the menu
  int menuSelection;
  //set which menu is displayed
  String activeMenu;
  //uses the controller data to move around
  GameController laManette;

  GUImenu(float xPos, float yPos, int xSize, int ySize) {
    super(xPos, yPos, xSize, ySize);
  }

  //a variant incase we pass it controller data
  GUImenu(float xPos, float yPos, int xSize, int ySize, GameController theController) {
    super(xPos, yPos, xSize, ySize);
    laManette = theController;
  }

  //this is what handles the different men to be shown
  void checkMenu() {
    //if theres an active menu
    if (activeMenu != null ) {
      thePlayer.setMobility(false);
      //checks for which menu to display
      if (activeMenu == "map")
        //and displays it
        mapMenu();
      if (activeMenu == "main")
        mainMenu();
      if (activeMenu == "pause")
        pauseMenu();
    }
  }

  void legitStart() {
    clean();
    theGUI.loading();
    thePlayer.activeMap = new Map(mapList[0], 0);
    activeMenu = null;
  }

  //this is the main menu, the first one to be shown
  void mainMenu() {
    //makes sure the menu selection isn't out of range
    menuSelection = constrain(menuSelection, 0, 2);
    //cleans the written text
    clean();
    //sets the text Size & color
    objectRender.textSize(textSize);
    objectRender.fill(0);
    //fills the text with the options
    objectRender.text("     Start", xTextMargin, yOffset+(yTextMargin*0));
    objectRender.text("     Exit", xTextMargin, yOffset+(yTextMargin*1));
    //    objectRender.text("     Debug", xTextMargin, yOffset+(yTextMargin*2));
    //draws an arrow at the menu selection variable
    objectRender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    objectRender.endDraw();
    //this long if statement check for both keyboard inputs and controller inputs
    //it might not be the most elegant way to do this, but for now it works
    ////////////MAP SELECTOR////////////////////
    if ((menuSelection == 0 && key == 'd' && keyReady) || (menuSelection == 0 && laManette.boutonA() && manette.hasNewData())) {
      //activeMenu = "map";
      legitStart();
    }
    ///////////EXIT FUNCTION////////////////
    if ((menuSelection == 1 && key == 'd' && keyReady) || (menuSelection == 1 && laManette.boutonA() && manette.hasNewData())) {
      //exit();
    }
    //////////////DEBUG + MAP///////////////////
    if ((menuSelection == 2 && key == 'd' && keyReady) || (menuSelection == 2  && laManette.boutonA() && manette.hasNewData())) {
      activeMenu = "map";
//      debug = true;
      clean();
    }
    //set that a key as been pressed, to prevent from skipping menu
    keyReady = false;
  }

  //this is the menu you can acces ingame to restart the game, 
  //all the comments can be taken from the MainMenu, since there's mostly based on the same format
  void pauseMenu() {
    menuSelection = constrain(menuSelection, 0, 1);
    clean();
    objectRender.beginDraw();
    objectRender.fill(0);
    objectRender.textSize(textSize);
    objectRender.text("     Re-Start", xTextMargin, yOffset+(yTextMargin*0));
    objectRender.text("     Exit", xTextMargin, yOffset+(yTextMargin*1));
    objectRender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    objectRender.endDraw();
    if ((menuSelection == 0 && key == 'd' && keyReady) || (menuSelection == 0  && laManette.boutonA() && manette.hasNewData())) {
      legitStart();
      clean();
    }
    if ((menuSelection == 1 && key == 'd' && keyReady) || (menuSelection == 1   && laManette.boutonA() && manette.hasNewData())) {
      //exit();
    }
    keyReady = false;
  }

  //this menu allow you to select a map to be played, 
  //all the comments can be taken from the MainMenu, since there's mostly based on the same format
  void mapMenu () {
    menuSelection = constrain(menuSelection, 0, 3);
    clean();
    objectRender.beginDraw();
    objectRender.fill(0);
    objectRender.textSize(textSize);
    objectRender.text("     Garage", xTextMargin, yOffset+(yTextMargin*0));
    objectRender.text("     Exterieur", xTextMargin, yOffset+(yTextMargin*1));
    objectRender.text("     Gourdi", xTextMargin, yOffset+(yTextMargin*2));
    objectRender.text("     Retour", xTextMargin, yOffset+(yTextMargin*3));
    objectRender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    objectRender.endDraw();

    //since all the choice you can make in this menu
    //only load a map, a for loop was used to shorten the code
    for (int i = 0; i < 4; i++) {
      if ((menuSelection == i && key == 'd' && keyReady) || (menuSelection == i && laManette.boutonA() && manette.hasNewData())) {
        clean();
        thePlayer.activeMap = new Map(mapList[i], i);
        activeMenu = null;
      }
    }

    keyReady = false;
  }

  //accessor for the active menu variable  
  String getActiveMenu() {
    return activeMenu;
  }

  //sets the active menu
  void setMenu(String state) {
    activeMenu = state;
  }

  //handles all the controller information
  void checkController() {
    //Pause button
    if (manette.boutonStart() && manette.hasNewData()) activeMenu = "pause";
    //up button for the menu selection
    if (manette.boutonDown() && manette.hasNewData()) menuSelection += 1; 
    //down button for the menu selection
    if (manette.boutonUp() && manette.hasNewData()) menuSelection -= 1;
  }

  //makes use of W and S to for upward or downward in the menu
  void keyPressed() {
    if (key == 'w') menuSelection -= 1;        //UP
    if (key == 's') menuSelection += 1;        //DOWN
  }
}

