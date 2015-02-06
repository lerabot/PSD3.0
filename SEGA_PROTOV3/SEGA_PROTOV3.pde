/////////////////////////////////////
//Presqu'un SEGA Dreamcast//
//À ouvrir avec processin 2.2.1 32-bit
//camera doc : http://gdsstudios.com/processing/libraries/ocd/reference/Camera/
/////////////////////////////////////

int time;
int lastTime;
boolean debug = false;

void setup() {
  size(830, 670, P3D);
  noCursor();
  //Dictionnary and Text
  lines = loadStrings("text.txt");
  myFont = loadFont("psdFont.vlw");
  
  //Serial
  println(Serial.list());
  serialPort = new Serial(this, Serial.list()[0], 9600);
  clearLCD();
  serialPort.write("Game Loading$");

  //Camera
  //initialize the camera
  explorerCam = new Camera (this, 0, -explorerHeight, 0, 0, -explorerHeight, -2000);
  //sets the pedrspective
  explorerCam.zoom(0.01);
  //feed the camPosition variable with the initial position
  camPosition = explorerCam.position();
  camTarget = explorerCam.target();
  PVcamPosition = new PVector (camPosition[0], camPosition[1], camPosition[2]);
  PVcamTarget = new PVector (camTarget[0], camTarget[1], camTarget[2]);

  //Maps
  //  myArcade = new Map(5, "L'arcade");
  //  myGarage = new Map(5, "Le Garage");  
  myPapiGarage = new Map(30, "Chez Jeannot"); 
//    myPapiExt = new Map(3, "Ext"); 
  //  myPapi = new Map(30, "papi"); 

  serialPort.write("Complete!$");
}


void draw() {
  ///////////////////////////
  time = millis();
  background(0);
  //  lights();
  //////////////////////////


  //////////////////////////
  //updateItemMenu();
  updateCameraData();

  ///////////////////////////  
  progression();      
  //  items();      

  if (debug) {
    debugMode();
  }



  explorerCam.feed(); 
  ////////////////////////////
}

void progression() {
  //  if (!introDone) splashScreen();

  //allows movement and rotation
  cameraRotation();
  cameraMovement();
  //shows the map depending on the currentMap String
  if ( currentMap == "Chez Jeannot") myPapiGarage.show();
  if ( currentMap == "Ext") myPapiExt.show();
  //a quick and a rough way to change map
  if ( currentMap == "Le Garage") {
    if (time > 100000) {
      currentMap = "arcade";
      explorerCam.jump(-1180, 200, 200);
      explorerCam.aim(-1180.8735, 200, 1000.0974);
    }
  }
//  showSnow();
}


void splashScreen() {
  PVector textLoc = PVector.lerp(PVcamPosition, PVcamTarget, 0.3);
  fill(255);
  textAlign(CENTER);
  textFont(myFont, 80);
  text("Presqu'un Sega Dreamcast", textLoc.x, textLoc.y-200, textLoc.z);
  textFont(myFont, 40);
  text("Start", textLoc.x, textLoc.y+150, textLoc.z);
}



/////KEYPRESSES//////
void keyPressed() {  
  cameraWASD();
  itemList();
  if (key == 27) exit();
  if (key == 112) debug = !debug;
}

