///////////////////////////////////////
//This is all the text part of the game.
//It is currently being partly rewritten and cleaned up.
//I'm currently working on a way to have a basic GUI with the text and such.
///////////////////////////////////////

class lcdText {

  String[] theText;
  PVector textPosition;

  int[] lineNum = new int [3];
  //has the text been displayed
  boolean textDisplayed;
  //the text "name"
  String name;
  //used for the debug color ball
  color ballColor;
  //when has it been displayed
  int displayedAt = 0;
  int delaySecondText;
  float reachDist = 0.35;
  boolean uniqueText = false;

  lcdText(PVector textPosition, int lineNum, String name, String[] theText) {
    this.textPosition = textPosition;
    this.lineNum[0] = lineNum;
    textDisplayed = false;
    this.name = name;
    this.theText = theText;
  }

  /////////////////////////////////////////////////////
  //WORK ON THIS, THIS SORTA WORK NOW
  //////////////////////////////////////////////////////
  void nearTextNoScreen () {
    //adds a delay to prevent from redoing the action
    if (displayedAt + 1500 < time ) { 
      //si ton "reach" est dans un perimetre de 400 de l'object en question
      if (textPosition.dist(textReach()) < 400) {
        ballColor = color(0, 255, 0);
        // check pour qu'il n'envois qu'une fois le text a l'écran
        if (currentText != lineNum[0]) {
          displayedAt = time;
          textDisplayed = true;
          int position = 0;
          theGUI.clean();
          for (int i = 0; i < theText.length; i++) {
            if (theText[i] != null)
              theGUI.GUItext(theText[i], 7+position*15);              
            position++;
          }
        }
        //        if (lineNum[1] != 0 && displayedAt+delaySecondText < time) {
        //          displayedAt = time;
        //          textDisplayed = true;
        //          int position = 0;
        //          for (int i = lineNum[1]; i < lineNum[1]+4; i++) {
        //            wLCD(lines[i], position);
        //            position++;
        //          }
        //        }
      } else {
        if (textDisplayed) {
          theGUI.clean();
          textDisplayed = false;
        }
        ballColor = color(255, 0, 0);
      }
    }
    if (debug) {
      pushMatrix();
      translate(textPosition.x, textPosition.y, textPosition.z);
      rotateY(frontPlane());
      text(name, 0, -100, 0);
      noStroke();    
      fill(ballColor);
      sphere(60);
      popMatrix();
    }
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

