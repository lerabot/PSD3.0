///////////////////////////////////////
//This is all the text part of the game.
//It is currently being partly rewritten and cleaned up.
//I'm currently working on a way to have a basic GUI with the text and such.
///////////////////////////////////////

class lcdText {
  //actual text
  ArrayList<String> theText;
  //its position
  PVector textPosition;
  //the text "name"
  String name;
  //used for the debug color ball
  color ballColor = color(0, 20, 180);
  //when has it been displayed
  int displayedAt = 0;
  //distance at which the text is triggered
  float reachDist = 0.20;
  //iss this text meant to be red only once?
  boolean uniqueText = false;
  //is the text a time-text?
  boolean isLocationBased;
  //if the text is longer than 4 lines
  boolean longText = false;
  //has the text arealy been read
  boolean beenRead = false;
  //
  int textDelay = 4500;

  int linePosition = 0;


  lcdText(PVector textPosition, int lineNum, String name, ArrayList<String> theText, boolean locationBased) {
    this.textPosition = textPosition;
    this.name = name;
    this.theText = theText;
    isLocationBased = locationBased;
  }

  lcdText(PVector textPosition, int lineNum, String name, ArrayList<String> theText, boolean locationBased, boolean longText) {
    this.textPosition = textPosition;
    this.name = name;
    this.theText = theText;
    isLocationBased = locationBased;
    this.longText = longText;
    if (longText)
      println(name +"is a longtext");
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
      //puts the ball in it's original color;
      theGUI.getCurrentText().ballColor = color(0, 20, 180);
      //clean the text box
      theGUI.cleanText();
      //does a check if it's a long text to write the other parts
      if (theGUI.getCurrentText().longText && !beenRead) {
        theGUI.getCurrentText().writeText();
      } else {
        //reset the textState to empty (flase)
        theGUI.setTextState(false, this);
      }
    }

    //this writes a non location based text after a certain delay.
    if (theGUI.noTextSince() > 10000) {
      //checks if it's a location based text, and if the text as already been displayed
      if (isLocationBased == false && beenRead == false) {
        writeText();
      }
    }
  }


  void writeText() {
    int position = 0;
    //    if (beenRead && linePosition != 0)
    //      beenRead = false;
    //    if (linePosition >= 4) {
    //      theGUI.cleanText();
    //      writeNextText();
    //    } else {
    for (int i = linePosition; i < linePosition + 4; i++) {
      if (i < theText.size()) {  
        if (theText.get(i) != null) {
          theGUI.writeText(theText.get(i), position);              
          position++;
        }
      } else {
        beenRead = true;
      }
    }
    if (beenRead) {
      linePosition = 0;
    } else {
      linePosition += 4;
    } 
    theGUI.setTextState(true, this);
  }


  void writeNextText() {
    int position = 0;
    for (int i = linePosition; i < linePosition+4; i++) { 
      if (i < theText.size()) {   
        if (theText.get(i) != null) {
          theGUI.writeText(theText.get(i), position);              
          position++;
        }
      } else {
        beenRead = true;
        linePosition = 0;
      }
    }
    linePosition += 4;
    theGUI.setTextState(true, this);
  }

  void textDebug() {
    //(debug) {
    pushMatrix();
    translate(textPosition.x, textPosition.y, textPosition.z);
    rotateY(frontPlane()[0]);
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

