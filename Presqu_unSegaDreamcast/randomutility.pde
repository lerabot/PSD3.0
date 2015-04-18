///////////////////////////////////////
//Random little hack or thing I use from time ot time. 
///////////////////////////////////////

void storm() {
  if (random(1.000) > 0.98) {
    ambientLight(250, 250, 255);
  }
}


void addController() {
  if (Serial.list().length > 0) {
    serialPort = new Serial(this, Serial.list()[0], 112500);
    manette = new GameController(serialPort, true);
    println("Manette Ready");
  } else {
    manette = new GameController(null, false);
    println("No Manette");
  }
}

void flashLight() {
  PVector lightDirection = PVector.sub(thePlayer.getPosition(), thePlayer.getTarget());
  lightDirection.mult(-1);
  lightDirection.normalize();
  spotLight(100, 100, 100, 
  thePlayer.getPosition().x, thePlayer.getPosition().y, thePlayer.getPosition().z, 
  lightDirection.x, lightDirection.y, lightDirection.z, 
  radians(30), 5);
}

float[] frontPlane() {
  return explorerCam.attitude();
}

//just shows a green dot a specified location
void showTarget(float x, float y, float z) {
  pushMatrix();
  noStroke();
  translate(x, y, z);
  fill(0, 255, 0);
  box(12);
  popMatrix();
}

//just shows a green dot a specified location
void showTarget(PVector pos) {
  pushMatrix();
  noStroke();
  translate(pos.x, pos.y, pos.z);
  fill(0, 255, 0);
  box(12);
  popMatrix();
}

void itemStick() {
  PVector itemStick;
  itemStick = PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.9);

  //  println(itemStick+" stick");
  //  println(PVcamTarget+" target");   
  strokeWeight(30);
  stroke(255);
  line(thePlayer.playerPosition.x, thePlayer.playerPosition.y, thePlayer.playerPosition.z, itemStick.x, itemStick.y, itemStick.z);
}

void captureFrame() {
  if (captureOn && frameCount % 4 == 0) {
    saveFrame("M:/sega dreamcast/capturedFrame/frame######.png");
  }
}




void mouseClicked() {
  //  println("Feet "+thePlayer.getFeet());
  println("Position "+thePlayer.getPosition());
  println("Target "+thePlayer.getTarget());
  //  println("Distance "+PVector.dist(thePlayer.getPosition(), thePlayer.getTarget()));
} 

