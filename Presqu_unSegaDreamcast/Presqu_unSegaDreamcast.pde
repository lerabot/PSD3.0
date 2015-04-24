/**
 * Title: PSD_0.6
 * Name: Roby Provost Blanchard
 * Date: April 18th 2015
 * Description: Still not exatly done, but in a playeable state thoughout the 4 maps.
 */
 
//UNDER GPL2.0 LICENSE


//SETUP///////
void setup() {
  //set the size of the canevas
  size(GAME_WIDTH, GAME_HEIGHT, P3D);
  //load the map names
  mapList = loadStrings("data/maps.txt");
  //GameController////////////////////////////////////////////
  //checks if there's a controller plugged into the serial port and add a controller object.
  addController();
  //Camera///////////////////////////////////////////////////////////////
  //creates a camera and set it's attributes
  explorerCam = new Camera (this, 0.85, 1.77, 100, 100000);
  //create a player Object and passes the camera
  thePlayer = new Player(explorerCam, manette);
  //GUI///////////////////////////////////////////////////////////////
  //creates a new GUI an inform that there's a controller
  theGUI = new GUI(manette);
  //disable the cursor appearence
  noCursor();
}


//DRAW///////
void draw() {
  //set a drakish background color
  background(30);
  //make sure the time is synced with the elapsed time
  time = millis();
  //passes the controller data where it is needed
  controllerPressed();
  //updates the controller information, if there's a controller
  manette.updateControllerData();
  //draws everything that is related to 3D
  draw3DWorld(); 
  //renders the camera and updates all the camers info
  thePlayer.render();
  //draws the GUI and all it's element
  theGUI.display();
  //simple function to allow to capture each frame to make gifs or video.
  captureFrame();
}


//passes the controller data where it,s needed
void controllerPressed() {
  if (theGUI.activeMenu() != null) {
    theGUI.checkController();
  } else if (thePlayer.activeMap != null) {
    thePlayer.checkController();
  }
}


//The main display of the game happpens here
void draw3DWorld() {
  if (thePlayer.activeMap != null) {
    thePlayer.getMap().show();
  } else {
    //shows the intro screen if no map is loaded
    theGUI.showIntroScreen();
  }

  if (manette.boutonStart() && manette.hasNewData()) {
    if (theGUI.activeMenu() == null) {
      theGUI.setMenu("pause");
    } else if (theGUI.activeMenu() == "pause") {
      theGUI.setMenu(null);
    }
  }
}

/////KEYPRESSES//////
void keyReleased() {
  //if the key is released, menus and other thing can accept new input
  //mostly prevents reteading in the menu
  keyReady = true;
}

void keyPressed() { 

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
  
  //sets the menu to pause
  if (key == 'q') {
    theGUI.setMenu("pause");
  }
  //exit the software
  if (key == 27) {
    //is there's a serial port,
    if (serialPort != null) {
      //clears the data
      serialPort.clear();
      //and closes the port
      serialPort.stop();
      println("serial dead");
    }
    //exits the program
    exit();
  }

  //switched the debug mode
  if (key == 'p') 
    debug = !debug;

  //this flag set that the key is pressed and should no be repeated  
  keyReady = false;
}

