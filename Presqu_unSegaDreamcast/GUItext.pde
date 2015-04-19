//a text box basicly
class GUItext extends GUIobject {
  
  
  GUItext(float xPos, float yPos, int xSize, int ySize) {
    super(xPos, yPos, xSize, ySize);
  }

  GUItext(float xPos, float yPos, int xSize, int ySize, String imageLoc) {
    super(xPos, yPos, xSize, ySize, imageLoc);
  }

//writes the text on the screen, use a number from 0 to 3 to set the line position
  void writeText(String input, int yPos) {
    objectRender.beginDraw();
    //makes sure the text is written in black
    objectRender.fill(0);
    //makes sure the text is at the good size
    objectRender.textSize(textSize);
    //writes the inputed text at desired line
    objectRender.text(input, xTextMargin, yOffset+(yTextMargin*yPos));
    objectRender.endDraw();
  }

  //almost the same thing but this one displays PVector information
  void writeText(PVector input, int yPos) {
    objectRender.beginDraw();
    objectRender.stroke(0);
    objectRender.textSize(textSize);
    //writes PVector information as int at desired line position
    objectRender.text(int(input.x)+" "+int(input.y)+" "+int(input.z), xTextMargin, yOffset+(yTextMargin*yPos));
    objectRender.endDraw();
  }
}

