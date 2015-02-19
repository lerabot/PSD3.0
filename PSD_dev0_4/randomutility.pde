void storm() {
  if (random(1.000) > 0.98) {
    ambientLight(250, 250, 255);
  }
}

//void flashLight() {
//  spotLight(255, 250, 250.0, PVcamPosition.x, PVcamPosition.y, PVcamPosition.z, PVcamTarget.x, PVcamTarget.y, PVcamTarget.z, 5, 5);
//}

void debugMode() {
  itemStick();
//  showTarget();
}

void showTarget(float x, float y, float z) {
  pushMatrix();
  noStroke();
  translate(x, y, z);
  fill(0, 255, 0);
  sphere(25);
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

