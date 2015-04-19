//superclass for every gui element you want to add.
class GUIobject {

  //background image of the GUI object
  PImage bgImage;
  //set if object is visible or not
  boolean showObject = true;
  //position and size of the GUI object
  PVector position;
  int xSize;
  int ySize;
  //the GUI object is rendered as a seperate PGraphic
  PGraphics objectRender; 
  //mostly font related settings
  final int textSize = 14;  //14 font size is cute
  final int xTextMargin = 10;  //margin from the left of the pGraphics
  final int yTextMargin = 15; //margin from the top of the pGraphics
  final int yOffset = 7; //every line is this variable high


  GUIobject(float xPos, float yPos, int xSize, int ySize) {
    //creates a new pvector at said position
    position = new PVector(xPos, yPos, 0);
    //create a pgraphics object of the definied size
    objectRender = createGraphics (xSize, ySize);
    //keeps a reference of the size 
    this.xSize = xSize;
    this.ySize = ySize;
    //loads the default backgroud image
    bgImage = loadImage("textbox.png");
    //renders said object on screen
    objectRender.image(bgImage, 0, 0);
    //sets the text alignment
    objectRender.textAlign(LEFT, TOP);
  }

  //the only differnece with this one is the custon background image
  GUIobject(float xPos, float yPos, int xSize, int ySize, String imageLoc) {
    position = new PVector(xPos, yPos, 0);
    objectRender = createGraphics (xSize, ySize);
    this.xSize = xSize;
    this.ySize = ySize;   
    //loads the custon background image instead.
    bgImage = loadImage(imageLoc);
    objectRender.image(bgImage, 0, 0);
    objectRender.textAlign(LEFT, TOP);
  }

  //accesor to draw the actuall GUI object
  PGraphics drawObject() {
    return objectRender;
  }

  //redraws the background
  void clean() {
    objectRender.beginDraw();
    objectRender.image(bgImage, 0, 0);
    objectRender.endDraw();
  }

  //gets the GUI object position
  PVector getPosition() {
    return position;
  }

  //set the object visibility
  void showObject(boolean state) {
    showObject = state;
  }

  //moves the GUI object on the screen
  void moveObject(PVector mouvement) {
    position.add(mouvement);
  }
}

