////////////////////////////////
//This class handles the player action such as moving, turning, taking and using things
//This is where all the camera info should be.
////////////////////////////////

Player thePlayer;

class Player {
  //hold the camera position and target
  Camera playerCamera;
  PVector playerPosition;
  PVector playerTarget;
  PVector playerHeadMovement;
  //this is important has it set the camera elevation from the floor
  float playerHeight = 100;
  //flag to allow or not movement
  boolean canMove = true;
  boolean canRotate = true;


  //variable related to the walk action
  int walkDirection = 0; // 0=stop 1=forward -1=backward
  final float walkDistance = 400; //
  float walkStep = 25; //
  int walkDone = 0;
  float walkBumpAngle;

  //same as up here but for rotation movement
  float rotationAngle = 0;
  int rotationTime = 10;
  int rotationDone = 0;

  String inMap;

  Player(Camera cam) {      
    this.playerCamera = cam;
    //sets the perspective
    this.playerCamera.zoom(0.01);
    //feed the camPosition variable with the initial position
    playerPosition = new PVector(0, 0, 0);
    playerTarget = new PVector(0, 0, 0);
    playerHeadMovement = new PVector(0,0,0);
    playerPosition.set(cam.position());
    playerTarget.set(cam.target());
    canMove = true;
    canRotate = true;
  }

  //render the scene depending on camera location, this is the fonction to add in the main loop
  void render() {
    if (canMove) 
      walk();
    if (canRotate) 
      turnAround();
    headMotion();
    updateCameraData();
    playerCamera.feed();
  }

  //makes sure all the camera info is up to date
  void updateCameraData() {  
    //gets the info from the explorerCam function and sets it to a float array
    playerPosition.set(playerCamera.position());
    playerTarget.set(playerCamera.target());
  }

  //linear movement forward or backward
  void walk() {
    if (walkDirection != 0) {
      if (walkDone < 25) {
        playerCamera.dolly(walkDirection*(walkDistance/walkStep));
        playerCamera.track(0.0, sin(-walkBumpAngle)*3);
        walkDone++;
        walkBumpAngle+= TWO_PI/walkStep;
      } else {
        walkDone = 0;
        walkDirection = 0;
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
    playerHeadMovement.mult(0.76);
    playerHeadMovement.limit(0.005);
    playerCamera.tumble(playerHeadMovement.x, playerHeadMovement.y);
  }




  //using the W A S D pattern to move the camera around
  void cameraWASD() {
    if (key == 97) rotationAngle = - 0.35;     //A
    if (key == 100) rotationAngle = + 0.35;    //D
    if (key == 119) walkDirection = -1;           //W
    if (key == 115) walkDirection = +1;        //S
    if (key == 114) println(myPapiExt.checkFloor());
  }

  //teleports the player to said location
  void cameraJump(float x, float y, float z) {
    playerCamera.jump(x, y, z);
  }
  //aim the camera at said location
  void cameraAim(float x, float y, float z) {
    playerCamera.aim(x, y, z);
  }


  //ACCESSORS AND OTHER SHORT FUNCTIONS////////////////////////////////////////////////
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

  void isIn(String mapName) {
    inMap = mapName;
  }

  float getAngle() {
    println(getDirection().heading());
    return getDirection().heading();
  }

  String currentMap() {
    return inMap;
  }

  PVector itemStick() {
    return PVector.lerp(thePlayer.getPosition(), thePlayer.getTarget(), 0.5);
  }
}

