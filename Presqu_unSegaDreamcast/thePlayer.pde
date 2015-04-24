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
  int currentMapIndex = 0;
  int frameToChange;
  boolean newMapLoading = false;
  int delayForMapChange = 240;

  //keeps the controller data
  GameController manette;

  //keeps track of the player Position (which is also the camera position)
  PVector playerPosition;
  //this is the player direction, also the caera "aim"
  PVector playerTarget;
  //this is the direction of the head movement
  PVector playerHeadMovement;
  //this is the current direction as a -1 for bacward or +1 for forward
  int direction;
  //check the next elevation, NOT IMPLEMENTED ATM
  float nextY;
  //this is important has it set the camera elevation from the floor
  float playerHeight = 100;
  //flag to allow or not movement
  boolean canMove = true;
  boolean canRotate = true;
  //check if the player is currently on level with the current floor topography
  boolean onFloor;


  //variable related to the walk action 
  int walkDirection = 0; // 0=stop 1=forward -1=backward
  //distance of each walk
  final float walkDistance = 400; //
  //number of frame for the walk animation to complete
  float walkAnimationLength = 25; //
  //indexes at which frame the walking animation is currently
  int currentWalkFrame = 0;
  //keeps track of the offset for the SIN used in the walk motion
  float walkBumpAngle;
  float yDistance;

  //same as up here but for rotation movement
  float rotationAngle = 0;
  int rotationTime = 10;
  int rotationDone = 0;



  Player(Camera cam, GameController manette) {   
    //passes the camera object   
    this.playerCamera = cam;
    //sets the perspective
    this.playerCamera.zoom(0.01);
    //initialize a bunch of variable need by the class
    playerPosition = new PVector(0, 0, 0);
    playerTarget = new PVector(0, 0, 0);
    playerHeadMovement = new PVector(0, 0, 0);
    //feed the camPosition variable with the initial position and aim
    playerPosition.set(cam.position());
    playerTarget.set(cam.target());
    //set the player as a movable and rotatable object
    canMove = true;
    canRotate = true;
    //sets the aim at 1000 pixel deep
    cameraAim(0, 0, -1000);
    this.manette = manette;
  }

  //render the scene depending on camera location, this is the fonction to add in the main loop
  void render() {
    if (activeMap != null) {
      //render a subtle motion so the scene is not fully static
      headMotion();
      //calculate the position of the player
      updatePosition();
      //check for map changes
      checkForMapChange();
    }
    //makes sure the camera data and player position are synced 
    updateCameraData();
    //renders the camera
    playerCamera.feed();
//////////////////////////GHETTO FUNCTION TO KEEP PLAYER AROUND GROUND///////////////////////
    if (playerPosition.y > 120 || playerPosition.y < 80) {
      cameraJump(playerPosition.x, playerHeight, playerPosition.z);
      cameraAim(playerTarget.x, playerHeight, playerTarget.z);
    }
  }

  //checks for map changes
  void checkForMapChange() {

    //This is for automatic map changes
    if (activeMap.getMaxTimeInMap() + inMapSince < millis() && !newMapLoading) {
      //increments the map index, so it goes to the next map in the list
      currentMapIndex++;
      //only goes to the next map if the name is longer than 0 char
      if (mapList[currentMapIndex].length() > 0) {
        println("Next map is : "+mapList[currentMapIndex]);
        //reset the GUI text, sometime a text would jam up at this point, so this prevent the bug
        theGUI.setTextState(false, null);
        //loads new map object
        loadMap(frameCount + delayForMapChange);
        setMobility(false);
        newMapLoading = true;
      } else {
        //if the next has no character, it means this was the last map
        //therefor, return to the main menu
        theGUI.setMenu("main");
        //reset the position of the camera
        resetPosition();
        //and active map points to nothing
        thePlayer.activeMap = null;
      }
    } 
    setNewMap(mapList[currentMapIndex], currentMapIndex);
  }

  void setNewMap(String mapName, int mapNumber) {
    if (newMapLoading)
      theGUI.loading(); 
    if (frameCount == frameToChange && newMapLoading) {
      thePlayer.activeMap = new Map(mapName, mapNumber);
      theGUI.cleanText();
      setMobility(true);
      newMapLoading = false;
    }
  }

  //not currently implemented , but allow a LOADING SCREEN before the game "freeze" to get a new map
  void loadMap(int frameToChange) {
    this.frameToChange = frameToChange;
  }


  //makes sure all the camera info is up to date
  void updateCameraData() {  
    //gets the info from the explorerCam function and sets it to a float array
    playerPosition.set(playerCamera.position());
    playerTarget.set(playerCamera.target());
  }

  //this fonction checks if the player can move or turn, and constantly run
  //in case some inputs have been made
  void updatePosition() {
    if (canMove) 
      goTo();
    if (canRotate) 
      turnAround();
  }

  //resets the camera to its initial position
  void resetPosition() {
    cameraJump(0.0, 0.0, 795.4339);
    cameraAim(100.21747, -7.848091E-5, -997.20087);
  }

  //checks if there's controller input
  void checkController() {
    //only checks if there's an actual controller object initialized
    if (manette != null) {
      //the C button hides the GUI
      if (manette.boutonC() && manette.hasNewData()) {
        theGUI.showGUI = !theGUI.showGUI;
      }
      //these are direction pad function, they control the player
      if (manette.boutonLeft()) rotationAngle = - 0.35;
      if (manette.boutonRight()) rotationAngle = + 0.35;
      if (manette.boutonUp()) direction = -1;           
      if (manette.boutonDown()) direction = 1;
    }
  }

  //using the W A S D pattern to move the camera around
  void keyPressed() {
    //the O key hides or shows the GUI
    if (key == 'o') theGUI.showGUI = !theGUI.showGUI;
    //these are direction or movement keys, they control the player
    if (key == 'a') rotationAngle = - 0.35;     //A
    if (key == 'd') rotationAngle = + 0.35;    //D
    if (key == 'w') direction = -1;           //W
    if (key == 's') direction = 1;        //S
  }


  void goTo() {
    //for anything to happens, it needs a direction
    if (direction != 0 && canMove) {
      //checks if this is the first frame of the loop
      if (currentWalkFrame == 0) {
        nextY = 0;
      }
      //if the animation is under the maximum number of frame
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
      } else { //when the loop is done
        //resets the walk counter
        currentWalkFrame = 0;
        //and the direction
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
      } else { //when the rotation is done
        //resets both the angle and the incrementation variable
        rotationDone = 0;
        rotationAngle = 0;
      }
    }
  }

  //adds a subtle head motion to make everything looks more natural
  void headMotion() {
    //gets a new random tumble vlaue for X and Y
    float tumbleValueX = random(-0.0002, 0.0002);
    float tumbleValueY = random(-0.0001, 0.0001);
    //adds them to the current head movement
    playerHeadMovement.add(tumbleValueX, tumbleValueY, 0);
    //divides the current movement by 2
    playerHeadMovement.mult(0.50);
    //limits the movement alot, to prevent from looking everywhere
    playerHeadMovement.limit(0.001);
    //adds the calculated movement to that actual look function
    playerCamera.look(playerHeadMovement.x, playerHeadMovement.y);
  }

  // gets a PVector that indicates the direction of the player in 3D space
  PVector getDestination(PVector objectPosition, float speed) {
    //gets the intial direction by substracting the player position from the object position
    PVector direction = PVector.sub(playerPosition, objectPosition);
    //normalize it to get a unit vector
    direction.normalize();
    //multiplies it by an inverse speed factor to be able to point toward the destination
    direction.mult(-speed);
    return direction;
  }

  //experimental function to make the player follow a said object, NOT IMPLEMENTED YET
  void follow(PVector object, float speed) {
    //make use of the getDestination vector to go somewhere
    PVector destination = getDestination(object, speed);
    trackCamera (destination.x, destination.z);
  }

  //////////////////////////////////////////////////
  //REPACKAGED CAMERA FUNCTIONS
  //////////////////////////////////////////////////

  //teleports the player to said location
  void cameraJump(float x, float y, float z) {
    playerCamera.jump(x, y, z);
  }
  //aim the camera at said location
  void cameraAim(float x, float y, float z) {
    playerCamera.aim(x, y, z);
  }

  //rotate the camera around while staying at the same place
  void rotateCamera(float angle) {
    playerCamera.pan(angle);
  }

  //move on the X,Y axis, doesn't change the aim
  void trackCamera(float xPos, float yPos) {
    playerCamera.track(xPos, yPos);
  }

  //stay at the same place, able to move upward/downward, and look around
  void lookCamera(float azimut, float elevation) {
    playerCamera.look(azimut, elevation);
  }

  //move the camera toward/backward the aim target
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
    if (state != canMove) {
      println("change movement state = "+ state);
      canRotate = state;
      canMove = state;
    }
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


  //this function get a linear interpolation of the player toward it's "aim" or the camera "aim"
  PVector playerLerp(float lerpDist) {
    //normalize and set the scale to 1000, so you get info from 0 to 1000 pixel
    playerTarget.normalize();
    playerTarget.setMag(1000);
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), lerpDist);
  }

  //a normalized version of the playerLerp
  PVector playerLerpNormalize() {
    //normalize and set the scale to 1000, so you get info from 0 to 1000 pixel
    PVector normalizedLerp = PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 1);
    normalizedLerp.normalize();
    return normalizedLerp;
  }

  //EXEPRIMENTAL, do not care aobut this
  PVector playerDirection(int walkDir) {
    playerTarget.normalize();
    playerTarget.setMag(1000);
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.3);
  }
}

