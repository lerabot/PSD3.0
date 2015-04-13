/**
 * Title: PSD_prototype
 * Name: Roby Provost Blanchard
 * Date: March 2nd 2015
 * Description: A working prototype of the map seconds level. use the W/A/S/D pattern to go around. press P for debug mode
 */

//simple flag to get faster loading if I don't need all the models
boolean debug = false;

void setup() {
  size(1280, 720, P3D);
  //the text stuff
  theFont = loadFont("psdFont.vlw");


  //Camera///////////////////////////////////////////////////////////////
  explorerCam = new Camera (this, 0.85, 1.77, 100, 100000);
  thePlayer = new Player(explorerCam);
  //GUI///////////////////////////////////////////////////////////////
  theGUI = new GUI();
}


//DRAW////////////////////////////////////////
void draw() {

  background(150);
  time = millis();
  progression(); 
  thePlayer.render();
  theGUI.display();
}



////////////////////////////////////////////////////
//The main display of the game happpens here
void progression() {
  if (thePlayer.activeMap != null) {
    thePlayer.getMap().show();
  } else {
    //shows the intro screen if no map is loaded
    //theGUI.showIntroScreen();
  }
  captureFrame();
}

void keyReleased() {
  keyReady = true;
}

/////KEYPRESSES//////
void keyPressed() { 

  //for camera movement using ASWD
  if (theGUI.activeMenu() != null) {

    theGUI.keyPressed();
  } else if (thePlayer.activeMap != null) {
    thePlayer.keyPressed();
  }
  //start a capture of frames
  if (key == 'c') {
    captureOn =! captureOn;
    println("Capture "+captureOn);
  }
  if (key == 'q') {
    theGUI.setMenu("pause");
  }
  //exit the software
  if (key == 27) exit();
  //switched the debug mode
  if (key == 112) debug = !debug;
  keyReady = false;
}

//BASIC TEST FOR INTRO SCREEN, WILL PROBABLY GET TRASHED SOON
//void splashScreen() {
//  PVector textLoc = PVector.lerp(PVcamPosition, PVcamTarget, 0.3);
//  fill(255);
//  textAlign(CENTER);
//  textFont(myFont, 80);
//  text("Presqu'un Sega Dreamcast", textLoc.x, textLoc.y-200, textLoc.z);
//  textFont(myFont, 40);
//  text("Start", textLoc.x, textLoc.y+150, textLoc.z);
//}

