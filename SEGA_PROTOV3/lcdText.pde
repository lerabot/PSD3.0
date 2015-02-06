class lcdText {

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



  public lcdText (float xPos, float yPos, float zPos, int lineNum, String name) {
    textPosition = new PVector(xPos, yPos, zPos);
    this.lineNum[0] = lineNum;
    textDisplayed = false;
    this.name = name;
  }

  public lcdText (float xPos, float yPos, float zPos, int lineNum, String name, boolean unique) {
    textPosition = new PVector(xPos, yPos, zPos);
    this.lineNum[0] = lineNum;
    textDisplayed = false;
    this.name = name;
    this.uniqueText = unique;
  }

  public lcdText (float xPos, float yPos, float zPos, int lineNum, String name, float reachDist) {
    textPosition = new PVector(xPos, yPos, zPos);
    this.reachDist = reachDist;
    this.lineNum[0] = lineNum;
    textDisplayed = false;
    this.name = name;
  }

  public lcdText (float xPos, float yPos, float zPos, int lineNum, int delay, int secondLineNum, String name) {
    textPosition = new PVector(xPos, yPos, zPos);
    this.lineNum[0] = lineNum;
    this.lineNum[1] = secondLineNum;
    this.delaySecondText = delay;
    textDisplayed = false;
    this.name = name;
  }


  void nearText () {
    if (displayedAt + 7500 < time) { 
      //si ton "reach" est dans un perimetre de 400 de l'object en question
      if (textPosition.dist(textReach()) < 400) {
        ballColor = color(0, 255, 0);
        // check pour qu'il n'envois qu'une fois le text a l'écran
        if (currentText != lineNum[0]) {     
          displayedAt = time;
          currentText = lineNum[0];
          textDisplayed = true;
          clearLCD();
          if (lineNum[1] != 0) wLCD("                  V", 3);
          int position = 0;
          for (int i = lineNum[0]; i < lineNum[0]+4; i++) {
            wLCD(lines[i], position);
            position++;
          }
        }
        if (lineNum[1] != 0 && displayedAt+delaySecondText < time) {
          displayedAt = time;
          textDisplayed = true;
          int position = 0;
          for (int i = lineNum[1]; i < lineNum[1]+4; i++) {
            wLCD(lines[i], position);
            position++;
          }
        }
      } else {
        if (textDisplayed) {
          clearLCD();
          textDisplayed = false;
        }
        ballColor = color(255, 0, 0);
      }
    }
    if (debug) {
      pushMatrix();
      textFont(myFont, 48);
      text(name, textPosition.x, textPosition.y-100, textPosition.z);
      rotateY(cameraNormal());
      popMatrix();
      pushMatrix();
      noStroke();
      translate(textPosition.x, textPosition.y, textPosition.z);
      fill(ballColor);
      sphere(60);
      popMatrix();
    }
  }

  PVector textReach() {
    PVector textReach;
    textReach = PVector.lerp(PVcamPosition, PVcamTarget, this.reachDist);
    return textReach;
  }
}

//////////////////////////LCD UTILITY/////////////////////////////////////////////

//write the string to the LCD at the set LINE position
void wLCD(String writtenText, int location) {
  serialPort.write(":w"+location+writtenText+"$");
  //  println(":w"+location+writtenText+"$");
}

//clears the LCD screen
void clearLCD () {
  serialPort.write("clear$");
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

