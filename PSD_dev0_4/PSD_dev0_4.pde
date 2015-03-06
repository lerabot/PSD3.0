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
  smooth();
  noCursor();
  //the text stuff
  neigeImg = loadImage("neige.png");
  lines = loadStrings("map1/map1_text.txt");
  theFont = loadFont("psdFont.vlw");


  onScreenText = createGraphics(400, 80, P3D);
  onScreenText.beginDraw();
  //  onScreenText.textFont(theFont, 60);
  onScreenText.textSize(20);
  onScreenText.textAlign(LEFT, TOP);
  onScreenText.endDraw();
  //Camera///////////////////////////////////////////////////////////////
  explorerCam = new Camera (this, 0.85, 1.77, 100, 100000);
  thePlayer = new Player(explorerCam);

  //Maps///////////////////////////////////////////////////////////////
  //initialize the first map to be showed
//  myGourdi = new Map(1, "Gourdi"); 
    myPapiExt = new Map(3, "Ext"); 

  //      myPapiGarage = new Map(30, "Garage"); 
  //  serialPort.write("Complete!$");
}


//DRAW////////////////////////////////////////
void draw() {
  background(127);
  time = millis();
  progression();      

  if (debug) {
    showTarget(thePlayer.itemStick().x, thePlayer.itemStick().y, thePlayer.itemStick().z);
  }

  thePlayer.render();
  GUI();
}


//graphical user interface (CURRENTLY IN TESTING)
void GUI() {
  pushMatrix();
  translate(GUIpos().x, GUIpos().y, GUIpos().z);
  rotateY(frontPlane());
  scale(0.25);
  imageMode(CENTER);
  image(onScreenText, 0, 270);
  popMatrix();
}

PVector GUIpos() {
  return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.1);
}


float frontPlane() {
  float[] att = explorerCam.attitude();
  return att[0];
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

