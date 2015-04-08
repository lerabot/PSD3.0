//superclass for every gui element you want to add.
class GUIobject {

  PImage bgImage;

  boolean showObject = true;

  PVector position;
  int xSize;
  int ySize;

  PGraphics objectRender; 

  final int textSize = 14;  //14 is cute
  final int xTextMargin = 10;
  final int yTextMargin = 15;
  final int yOffset = 7;

  GUIobject(float xPos, float yPos, int xSize, int ySize) {
    position = new PVector(xPos, yPos, 0);
    objectRender = createGraphics (xSize, ySize);
    this.xSize = xSize;
    this.ySize = ySize;
    bgImage = loadImage("textbox.png");
    objectRender.image(bgImage, 0, 0);
    objectRender.textAlign(LEFT, TOP);
  }

  PGraphics drawObject() {
    return objectRender;
  }

  void clean() {
    objectRender.beginDraw();
    objectRender.image(bgImage, 0, 0);
    objectRender.endDraw();
  }

  PVector getPosition() {
    return position;
  }

  void showObject(boolean state) {
    showObject = state;
  }

  void display() {
    if (showObject) {
    }
  }

  void moveObject(PVector mouvement) {
    position.add(mouvement);
  }
}

