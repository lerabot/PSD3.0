///////////////////////////////////////
//This is all the text part of the game.
//It is currently being partly rewritten and cleaned up.
//I'm currently working on a way to have a basic GUI with the text and such.
///////////////////////////////////////

class lcdText {
  //actual text
  String[] theText;
  //its position
  PVector textPosition;
  //has the text been displayed
  boolean textDisplayed;
  //the text "name"
  String name;
  //used for the debug color ball
  color ballColor = color(0, 20, 180);
  //when has it been displayed
  int displayedAt = 0;
  int delaySecondText;
  float reachDist = 0.20;
  boolean uniqueText = false;
  //is the text a time-text?
  boolean isLocationBased;
  boolean longText = false;

  int textDelay = 4500;

  int linePosition;


  lcdText(PVector textPosition, int lineNum, String name, String[] theText, boolean locationBased) {
    this.textPosition = textPosition;
    textDisplayed = false;
    this.name = name;
    this.theText = theText;
    isLocationBased = locationBased;
  }

  lcdText(PVector textPosition, int lineNum, String name, String[] theText, boolean locationBased, boolean longText) {
    this.textPosition = textPosition;
    textDisplayed = false;
    this.name = name;
    this.theText = theText;
    isLocationBased = locationBased;
    this.longText = longText;
    if (longText)
      println("longtext");
  }

  /////////////////////////////////////////////////////
  //WORK ON THIS, THIS SORTA WORK NOW
  //////////////////////////////////////////////////////
  void checkText() {
    //allow to see where the text are located;
    textDebug();
    //si ton "reach" est dans un perimetre de 400 de l'object en question
    if (textPosition.dist(textReach()) < 400) { 
      //checking if there is a text being displayed in the dialogBox
      if (!theGUI.isDisplayingText) {
        //changing the debug ball color
        ballColor = color(0, 170, 40);
        //actually writes the text in the GUI
        writeText();
      }
    } 

    //if there's an active text on the screen after the text display time
    if (theGUI.isDisplayingText && theGUI.noTextSince() > 3500) { 
      //clean the text box
      theGUI.cleanText();
      //reset the textState to empty (flase)
      theGUI.setTextState(false);
      //does a check if it's a long text to write the other parts
      if (longText && !textDisplayed) {
        println("punk");
        writeNextText();
      }
      //puts the ball in it's original color;
      ballColor = color(0, 20, 180);
    }

    //this writes a non location based text after a certain delay.
    if (theGUI.noTextSince() > 150000) {
      //checks if it's a location based text, and if the text as already been displayed
      if (isLocationBased == false && textDisplayed == false) {
        writeText();
      }
    }
  }


  void writeText() {
    int position = 0;
    theGUI.cleanText();
    for (int i = 0; i < 4; i++) {            
      if (theText[i] != null) {
        theGUI.writeText(theText[i], position);              
        position++;
      }
      linePosition = 4;
    }
    if (!longText)
      textDisplayed = true;
    theGUI.setTextState(true);
  }

  void writeNextText() {
    int position = 0;
    theGUI.cleanText();
    for (int i = linePosition; i < linePosition + 4; i++) {            
      if (theText[i] != null && i < theText.length) {
        theGUI.writeText(theText[i], position);              
        position++;
      } else if (theText[i] == null) {
        textDisplayed = true;
      }
    }
    linePosition += 4;
    if (!longText && linePosition < theText.length)
      textDisplayed = true;
    theGUI.setTextState(true);
  }

  void textDebug() {
    //(debug) {
      pushMatrix();
      translate(textPosition.x, textPosition.y, textPosition.z);
      rotateY(frontPlane());
      //      text(name, 0, -20, 0);
      noStroke();    
      fill(ballColor);
      sphereDetail(4);
      sphere(25);
      popMatrix();
   // }
  }

  PVector textReach() {
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), reachDist);
  }
}

//////////////////////////LCD UTILITY/////////////////////////////////////////////



//write the string to the LCD at the set LINE position
void wLCD(String writtenText, int location) {
  //  serialPort.write(":w"+location+writtenText+"$");
  //  println(":w"+location+writtenText+"$");
}
//
////clears the LCD screen
void clearLCD () {
  //  serialPort.write("clear$");
}

//void updateItemMenu() {
//  if (millis() > serialDelay) {
////    lcdIntro();
//    if (introDone) {  
////      wLCD(currentMap+"$", 0);
//    }
//    serialDelay = millis() + 125;
//  }
//}

