///////////////////////////////////////
//Random little hack or thing I use from time ot time. 
///////////////////////////////////////

//NOT IMPLEMENTED, some sort of flickering light function
void storm() {
  //just a little probability checker, if goes trhough, adds an ambiant light
  if (random(1.000) > 0.98) {
    ambientLight(250, 250, 255);
  }
}

//this is the function that adds a controller if a serial port is detected
void addController() {
  //needs the SerialList to have more than 0 element to go through
  if (Serial.list().length > 0) {
    //creates a serial object wirth the first one in the list
    serialPort = new Serial(this, Serial.list()[0], 112500);
    //creates a Game Controller Object and passes the Serial port, and set the controller to ACTIVE
    manette = new GameController(serialPort, true);
    println("Manette Ready");
  } else {
    //else, it send a null message and set the controller to FALSE
    manette = new GameController(null, false);
    println("No Manette");
  }
}

//another lighting effect, like a (BAD) flashlight
void flashLight() {
  //uses the "aim" and player position to get a direction
  PVector lightDirection = PVector.sub(thePlayer.getPosition(), thePlayer.getTarget());
  //reverses the Vector, to point toward the front of the player
  lightDirection.mult(-1);
  //make a unit vector
  lightDirection.normalize();
  //use a spot light, it is located at the player position and point toward the front of it
  spotLight(100, 100, 100, 
  thePlayer.getPosition().x, thePlayer.getPosition().y, thePlayer.getPosition().z, 
  lightDirection.x, lightDirection.y, lightDirection.z, 
  //set the angle of the mean at 30degree
  radians(30), 5);
}

//return the rotation agle of the camera on the polar coordinates
float[] frontPlane() {
  return explorerCam.attitude();
}


//just shows a green dot a specified location
void showTarget(float x, float y, float z) {
  pushMatrix();
  noStroke();
  //uses the passed position to move the origin
  translate(x, y, z);
  //create a box just to identify the target
  fill(0, 255, 0);
  box(12);
  popMatrix();
}

//same thing as the on up there, but takes a PVector instead
void showTarget(PVector pos) {
  pushMatrix();
  noStroke();
  translate(pos.x, pos.y, pos.z);
  fill(0, 255, 0);
  box(12);
  popMatrix();
}

//some wierd debug function that draws a stick in front of you at a certain distance. NOT IMPLEMENTED
void itemStick() {
  PVector itemStick;
  //creates a pvector at a position between the player and it's "aim"
  itemStick = PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.9);
  //draws a white line between those 2 points
  strokeWeight(30);
  stroke(255);
  line(thePlayer.playerPosition.x, thePlayer.playerPosition.y, thePlayer.playerPosition.z, itemStick.x, itemStick.y, itemStick.z);
}

//a little function that captures frame to make gifs or video
void captureFrame() {
  //capture a frame every (IN THIS CASE) 4 frames
  if (captureOn && frameCount % 4 == 0) {
    saveFrame("M:/sega dreamcast/capturedFrame/frame######.png");
  }
}

//when the mouse is clicked is return various information
void mouseClicked() {
  //return the feet position
  //  println("Feet "+thePlayer.getFeet());
  //return the player position (CAMERA)
  println("Position "+thePlayer.getPosition());
  //returns the "aim" or target of CAMERA
  println("Target "+thePlayer.getTarget());
} 

