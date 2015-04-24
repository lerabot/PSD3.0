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
  //delay between each text
  int textDelay = 5000;
  int noTextDelay = 10000;
  //which line of thext is currently displayed
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
      println(name +" is a longtext" +theText.size());
  }

  lcdText(PVector textPosition, int lineNum, String name, ArrayList<String> theText, boolean locationBased, boolean longText, int noTextDelay) {
    this.textPosition = textPosition;
    this.name = name;
    this.theText = theText;
    isLocationBased = locationBased;
    this.longText = longText;
    this.noTextDelay = noTextDelay;
    if (longText)
      println(name +" is a longtext" +theText.size());
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
    if (theGUI.isDisplayingText && theGUI.noTextSince() > textDelay) { 
      println("erase text");
      //puts the ball in it's original color;
      theGUI.getCurrentText().ballColor = color(0, 20, 180);
      //clean the text box
      theGUI.cleanText();
      //does a check if it's a long text to write the other parts
      if (theGUI.getCurrentText().longText && theGUI.getCurrentText().beenRead == false) {
        theGUI.getCurrentText().writeText();
        println("long text");
      } else {
        //reset the textState to empty (false)
        theGUI.setTextState(false, this);
      }
    }

    //this writes a non location based text after a certain delay.
    if (theGUI.noTextSince() > noTextDelay) {
      //checks if it's a location based text, and if the text as already been displayed
      if (isLocationBased == false && beenRead == false) {
        println("noTextSince");
        theGUI.cleanText();
        writeText();
      }
    }
  }


  void writeText() {
    //reset the postition where the text is going to be written in the GUI
    int position = 0;
    //iterate through 4 line of the text
    for (int i = linePosition; i < linePosition + 4; i++) {
      //only get the next line if the index i smaller than the text size
      if (i < theText.size()) {
        //only write if there's something in the string
        if (theText.get(i) != null) {
          //writes a single line at the "position" 
          theGUI.writeText(theText.get(i), position);
          //augment the pausition index          
          position++;
        } else {
          println("this text has been read FULLY because there's a null LINE");
          beenRead = true;
        }
        //if the index is larger than the text size, flag the text as read.
      } else {
        println("this text has been read FULLY because the index is BIGGER OR EQUAL then the text Size");
        beenRead = true;
      }
    }
    //if the text has been read, reset the line to be written to 0
    if (beenRead) {
      linePosition = 0;
    } else {
      //otherwise, add 4.
      linePosition += 4;
    }
    println("has this text been read? "+beenRead);
    //sets the last displayed text to this text, and state that this is currently displayed.
    theGUI.setTextState(true, this);
  }

  //a little feature that visually respresent where the taxt are
  void textDebug() {
    if (debug) {
      pushMatrix();
      //transalte the origin to the text location
      translate(textPosition.x, textPosition.y, textPosition.z);
      //rotates the sketch so that everything is facing the camera, good for 2D elements
      rotateY(frontPlane()[0]);
      //      text(name, 0, -20, 0);
      //changes the style of the model
      noStroke();    
      fill(ballColor);
      sphereDetail(4);
      //draws the elements
      sphere(25);
      popMatrix();
    }
  }

  /////////////////////////////////////////////////////////
  //ACCESSOR
  /////////////////////////////////////////////////////////
  PVector textReach() {
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), reachDist);
  }

  void changeNoTextDelay(int time) {
    noTextDelay = time;
  }
}


//////////////////////////LCD UTILITY/////////////////////////////////////////////
//MOSTLY OUTDATED, USED FOR THE OLD LCD SCREEN, KEPPING THIS FOR FUTURE UPDATES
//////////////////////////////////////////////////////////////////////////////////

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

