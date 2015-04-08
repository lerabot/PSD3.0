//a text box basicly
class GUItext extends GUIobject {

  GUItext(float xPos, float yPos, int xSize, int ySize) {
    super(xPos, yPos, xSize, ySize);
  }

  void writeText(String input) {
    objectRender.beginDraw();
    objectRender.fill(255);
    objectRender.textSize(textSize);
    objectRender.text(input, 5, 5);
    objectRender.endDraw();
  }

  void writeText(String input, int yPos) {
    objectRender.beginDraw();
    objectRender.fill(0);
    objectRender.textSize(textSize);
    objectRender.text(input, xTextMargin, yOffset+(yTextMargin*yPos));
    objectRender.endDraw();
  }

  void writeText(float[] input, String name, int yPos) {
    objectRender.beginDraw();
    objectRender.stroke(200);
    objectRender.strokeWeight(5);
    objectRender.textSize(15);
    objectRender.text(name+" : X"+int(input[0])+" Y"+int(input[1])+" Z"+int(input[2]), 5, yPos);
    objectRender.endDraw();
  }
}

