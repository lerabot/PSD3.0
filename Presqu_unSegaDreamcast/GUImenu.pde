class GUImenu extends GUItext {

  int menuSelection;
  String activeMenu;

  GUImenu(float xPos, float yPos, int xSize, int ySize) {
    super(xPos, yPos, xSize, ySize);
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
    objectRender.textSize(textSize);
    objectRender.fill(0);
    objectRender.text("     Start", xTextMargin, yOffset+(yTextMargin*0));
    objectRender.text("     Exit", xTextMargin, yOffset+(yTextMargin*1));
    objectRender.text("     Debug", xTextMargin, yOffset+(yTextMargin*2));
    objectRender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    objectRender.endDraw();
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
    objectRender.beginDraw();
    objectRender.fill(0);
    objectRender.textSize(textSize);
    objectRender.text("     Re-Start", xTextMargin, yOffset+(yTextMargin*0));
    objectRender.text("     Exit", xTextMargin, yOffset+(yTextMargin*1));
    objectRender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    objectRender.endDraw();
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
    objectRender.beginDraw();
    objectRender.fill(0);
    objectRender.textSize(textSize);
    objectRender.text("     Garage", xTextMargin, yOffset+(yTextMargin*0));
    objectRender.text("     Exterieur", xTextMargin, yOffset+(yTextMargin*1));
    objectRender.text("     Gourdi", xTextMargin, yOffset+(yTextMargin*2));
    objectRender.text("     Retour", xTextMargin, yOffset+(yTextMargin*3));
    objectRender.text("->", xTextMargin, yOffset+(yTextMargin*menuSelection));
    objectRender.endDraw();
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
      thePlayer.activeMap = new Map(-3, "Retour");
      activeMenu = null;
    }

    keyReady = false;
  }

  String getActiveMenu() {
    return activeMenu;
  }

  void setMenu(String state) {
    activeMenu = state;
  }

  void keyPressed() {
    if (key == 'w') menuSelection -= 1;           //W
    if (key == 's') menuSelection += 1;        //S
  }
}

