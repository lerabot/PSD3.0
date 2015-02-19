/////////////////////////////////////
//Presqu'un SEGA Dreamcast//
//camera doc : http://gdsstudios.com/processing/libraries/ocd/reference/Camera/
/////////////////////////////////////


int time;
int lastTime;
boolean debug = true;



void setup() {
  size(1024, 768, P3D);
  noCursor();
  //Dictionnary and Text
  neigeImg = loadImage("neige.png");
  lines = loadStrings("text.txt");


  //Serial
  //  println(Serial.list())
  clearLCD();
  //  serialPort.write("Game Loading$");

  //Camera///////////////////////////////////////////////////////////////
  explorerCam = new Camera (this);
  thePlayer = new Player(explorerCam);


  //Maps///////////////////////////////////////////////////////////////
//  myPapiExt = new Map(5, "Ext"); 
      myPapiGarage = new Map(30, "Garage"); 
  //  serialPort.write("Complete!$");
}

////////////////////////////////////////
//DRAW
////////////////////////////////////////
void draw() {
  time = millis();
  background(127);
  progression();      

  if (debug) {
    debugMode();
  }
  thePlayer.render();
}

void progression() {
  //shows the map depending on the currentMap String
  if ( currentMap == "Garage") myPapiGarage.show();
  if ( currentMap == "Ext") myPapiExt.show();

  captureFrame();
}


//void splashScreen() {
//  PVector textLoc = PVector.lerp(PVcamPosition, PVcamTarget, 0.3);
//  fill(255);
//  textAlign(CENTER);
//  textFont(myFont, 80);
//  text("Presqu'un Sega Dreamcast", textLoc.x, textLoc.y-200, textLoc.z);
//  textFont(myFont, 40);
//  text("Start", textLoc.x, textLoc.y+150, textLoc.z);
//}

void captureFrame() {
  if (captureOn && frameCount % 5 == 0) {
    saveFrame("frame/output####.tif");
  }
}

/////KEYPRESSES//////
void keyPressed() {  
  thePlayer.cameraWASD();
  if (key == 'c') {
    captureOn =! captureOn;
    println("Capture "+captureOn);
  }
  itemList();
  if (key == 27) exit();
  if (key == 112) debug = !debug;
}

  void mouseClicked() {
    println("Position "+thePlayer.getPosition());
    println("Target "+thePlayer.getTarget());
  } 

