/**
 * Title: PSD_prototype
 * Name: Roby Provost Blanchard
 * Date: March 2nd 2015
 * Description: A working prototype of the map seconds level. use the W/A/S/D pattern to go around. press P for debug mode
 */

//simple flag to get faster loading if I don't need all the models
boolean debug = true;

void setup() {
  size(1280, 720, P3D);
  //the text stuff
  neigeImg = loadImage("neige.png");
  theFont = loadFont("psdFont.vlw");

  //GUI///////////////////////////////////////////////////////////////
  theGUI = new GUI();
  //  thePlayer.render();
  //Camera///////////////////////////////////////////////////////////////
  explorerCam = new Camera (this, 0.85, 1.77, 100, 100000);
  thePlayer = new Player(explorerCam);
  //Maps///////////////////////////////////////////////////////////////
  //initialize the first map to be showedr
  //  myGourdi = new Map(1, "Gourdi"); 
  // myPapiExt = new Map(3, "Ext"); 

  myPapiGarage = new Map(30, "Garage"); 
  //  serialPort.write("Complete!$");
}


//DRAW////////////////////////////////////////
void draw() {
  //  lights();
  background(127);
  time = millis();
  //  theGUI.clean();
  progression();      
  //  theGUI.GUItext(thePlayer.playerPosition.array(), "Position", 5);
  if (debug) {
    showTarget(thePlayer.itemStick().x, thePlayer.itemStick().y, thePlayer.itemStick().z);
  }

  thePlayer.render();
  theGUI.display();
}



////////////////////////////////////////////////////



//The main display of the game happpens here
void progression() {

  //shows the map depending on the currentMap String
  if ( thePlayer.currentMap() == "Garage") myPapiGarage.show();
  if ( thePlayer.currentMap() == "Ext") myPapiExt.show();
  if ( thePlayer.currentMap() == "Gourdi") myGourdi.show();
  captureFrame();
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

