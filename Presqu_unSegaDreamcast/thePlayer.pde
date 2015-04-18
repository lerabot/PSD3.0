////////////////////////////////
//This class handles the player action such as moving, turning, taking and using things
//This is where all the camera info should be.
////////////////////////////////

Player thePlayer;

class Player {
  //hold the camera position and target
  Camera playerCamera;
  //All the map info - The actual Map, if the player is in a map, 
  //the time he's entered the map, and what level he's in
  Map activeMap;
  boolean inMap;
  int inMapSince;
  int currentMapIndex;


  PVector playerPosition;
  PVector playerTarget;
  PVector playerHeadMovement;
  int direction;
  float nextY;
  //this is important has it set the camera elevation from the floor
  float playerHeight = 100;
  //flag to allow or not movement
  boolean canMove = true;
  boolean canRotate = true;
  boolean onFloor;



  //variable related to the walk action 
  int walkDirection = 0; // 0=stop 1=forward -1=backward
  final float walkDistance = 400; //
  float walkAnimationLength = 25; //
  int currentWalkFrame = 0;
  float walkBumpAngle;
  float yDistance;

  //same as up here but for rotation movement
  float rotationAngle = 0;
  int rotationTime = 10;
  int rotationDone = 0;



  Player(Camera cam) {      
    this.playerCamera = cam;
    //sets the perspective
    this.playerCamera.zoom(0.01);
    //feed the camPosition variable with the initial position
    playerPosition = new PVector(0, 0, 0);
    playerTarget = new PVector(0, 0, 0);
    playerHeadMovement = new PVector(0, 0, 0);
    playerPosition.set(cam.position());
    playerTarget.set(cam.target());
    canMove = true;
    canRotate = true;
    cameraAim(0, 0, -1000);
  }

  //render the scene depending on camera location, this is the fonction to add in the main loop
  void render() {
    if (activeMap != null) {
      headMotion();
      updatePosition();
      changeMap();
    }
    updateCameraData();
    playerCamera.feed();
  }


  void changeMap() {



    //void loadMap(String mapName, int mapNumber, int frameToChange) {   
    //      theGUI.writeText("LOADING", 1);
    //      if (frameCount == frameToChange) 
    //        thePlayer.activeMap = new Map(mapName, mapNumber);
    //    }


    //This is for automatic map changes
    if (activeMap.getMaxTimeInMap() + inMapSince < millis()) {
      currentMapIndex++;
      if (mapList[currentMapIndex].length() > 0) {
        //      theGUI.writeText(" Loading next map", 1);
        println("Next map is : "+mapList[currentMapIndex]);
        thePlayer.activeMap = new Map(mapList[currentMapIndex], currentMapIndex);
      } else {
        theGUI.setMenu("main");
        resetPosition();
        thePlayer.activeMap = null;
      }
    }
  }


  //makes sure all the camera info is up to date
  void updateCameraData() {  
    //gets the info from the explorerCam function and sets it to a float array
    playerPosition.set(playerCamera.position());
    playerTarget.set(playerCamera.target());
  }

  void updatePosition() {
    if (canMove) 
      goTo();
    if (canRotate) 
      turnAround();
  }

  void resetPosition() {
    cameraJump(0.0, 0.0, 795.4339);
    cameraAim(100.21747, -7.848091E-5, -997.20087);
  }

  void checkController() {
    if (manette != null) {
      if (manette.boutonC() && manette.hasNewData()) {
        theGUI.showGUI = !theGUI.showGUI;
      }
      if (manette.boutonLeft()) rotationAngle = - 0.35;
      if (manette.boutonRight()) rotationAngle = + 0.35;
      if (manette.boutonUp()) direction = -1;           
      if (manette.boutonDown()) direction = 1;
    }
  }

  //using the W A S D pattern to move the camera around
  void keyPressed() {
    if (key == 'o') theGUI.showGUI = !theGUI.showGUI;
    if (key == 'a') rotationAngle = - 0.35;     //A
    if (key == 'd') rotationAngle = + 0.35;    //D
    if (key == 'w') direction = -1;           //W
    if (key == 's') direction = 1;        //S
  }

  void goTo() {
    if (direction != 0) {
      if (currentWalkFrame == 0) {
        //        nextY = getFeetFloorDiff(-direction);
        nextY = 0;
      }
      if (currentWalkFrame < walkAnimationLength) {
        //forward movement
        playerCamera.dolly(direction*(walkDistance/walkAnimationLength));
        //y axis mouvement
        playerCamera.track(0.0, sin(-walkBumpAngle)*3);
        playerCamera.track(0.0, -nextY/walkAnimationLength);
        //the walk action happens over 25 frame, so thid acts as a counter
        currentWalkFrame++;
        //counter for the sin wave
        walkBumpAngle += TWO_PI/walkAnimationLength;
      } else {
        currentWalkFrame = 0;
        direction = 0;
      }
    }
  }

  //rotation around the Y axis, or panorama
  void turnAround() {
    //check the rotation Angle for a value change
    if (rotationAngle != 0) {
      //since the operation happens overtime, it check where the index for its current poisition
      if (rotationDone < rotationTime) {
        //simple operation ot divide therotation angle over time
        playerCamera.pan(rotationAngle/rotationTime);
        //increments the index
        rotationDone++;
        if (rotationDone == rotationTime) {
        }
      } else {
        //resets both the angle and the incrementation variable
        rotationDone = 0;
        rotationAngle = 0;
      }
    }
  }

  void headMotion() {
    float tumbleValueX = random(-0.0002, 0.0002);
    float tumbleValueY = random(-0.0001, 0.0001);
    playerHeadMovement.add(tumbleValueX, tumbleValueY, 0);
    playerHeadMovement.mult(0.50);
    playerHeadMovement.limit(0.001);
    playerCamera.look(playerHeadMovement.x, playerHeadMovement.y);
  }

  PVector getDestination(PVector objectPosition, float speed) {
    PVector direction = PVector.sub(playerPosition, objectPosition);
    direction.normalize();
    direction.mult(-speed);
    return direction;
  }

  void follow(PVector object, float speed) {
    PVector destination = getDestination(object, speed);
    trackCamera (destination.x, destination.z);
  }

  //teleports the player to said location
  void cameraJump(float x, float y, float z) {
    playerCamera.jump(x, y, z);
  }
  //aim the camera at said location
  void cameraAim(float x, float y, float z) {
    playerCamera.aim(x, y, z);
  }

  void rotateCamera(float angle) {
    playerCamera.pan(angle);
  }

  void trackCamera(float xPos, float yPos) {
    playerCamera.track(xPos, yPos);
  }

  void lookCamera(float azimut, float elevation) {
    playerCamera.look(azimut, elevation);
  }

  void dollyCamera(float speed) {
    playerCamera.dolly(speed);
  }

  //ACCESSORS AND OTHER SHORT FUNCTIONS////////////////////
  PVector getPosition() {
    return playerPosition;
  }

  PVector getTarget() {
    return playerTarget;
  }

  PVector getDirection() {
    return PVector.sub(playerPosition, playerTarget);
  }

  float getHeight() {
    return playerHeight;
  }

  PVector getFeet() {
    return new PVector (playerPosition.x, playerPosition.y+playerHeight, playerPosition.z);
  }

  float getFeetAsFloat() {
    return playerPosition.y+playerHeight;
  }

  float getFeetFloorDiff(int direction) {
    return getFeetAsFloat() - activeMap.getFloorLevel(direction);
  }

  float getAngle() {
    return getDirection().heading();
  }

  void setMobility(boolean state) {
    canRotate = state;
    canMove = state;
  }

  void setMap(Map theMap, int mapIndex) {
    currentMapIndex = mapIndex;
    activeMap = theMap;
    inMapSince = millis();
  }

  int getInMapSince() {
    return millis() - inMapSince;
  }

  void setInMapSince(int time) {
    inMapSince = time;
  }

  Map getMap() {
    return activeMap;
  }

  PVector playerLerp(float lerpDist) {
    //normalize and set the scale to 1000, so you get info from 0 to 1000 pixel
    playerTarget.normalize();
    playerTarget.setMag(1000);
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), lerpDist);
  }

  PVector playerLerpNormalize() {
    //normalize and set the scale to 1000, so you get info from 0 to 1000 pixel
    PVector normalizedLerp = PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 1);
    normalizedLerp.normalize();
    return normalizedLerp;
  }

  PVector playerDirection(int walkDir) {
    playerTarget.normalize();
    playerTarget.setMag(1000);
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.3);
  }
}

