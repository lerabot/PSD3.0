////////////////////////////////
//This class handles the player action such as moving, turning, taking and using things
//This is where all the camera info should be.
////////////////////////////////

class Player {
  Camera playerCamera;

  PVector playerPosition;
  PVector playerTarget;
  //this is important has it set the camera elevatio from the floor
  float playerHeight = 850;
  boolean canMove = true;
  boolean canRotate = true;

  //offset from the camera, to measure the player's height
  int explorerHeight = 850;

  //variable related to the walk action
  int walkDirection = 0; // 0=stop 1=forward -1=backward
  final float walkDistance = 300; //
  float walkStep = 25; //
  int walkDone = 0;
  float walkBumpAngle = TWO_PI/walkStep;
  float walkBumpIncr = 0;

  //same as up here but for rotation movement
  float rotationAngle = 0;
  int rotationTime = 10;
  int rotationDone = 0;


  Player(Camera cam) {      
    this.playerCamera = cam;
    //sets the pedrspective
    this.playerCamera.zoom(0.01);
    //feed the camPosition variable with the initial position
    float[] camPosition = playerCamera.position();
    float[] camTarget = playerCamera.target();
    playerPosition = new PVector (camPosition[0], camPosition[1], camPosition[2]);
    playerTarget = new PVector (camTarget[0], camTarget[1], camTarget[2]);
    canMove = true;
    canRotate = true;
  }

  //render the scene depending on camera location, this is the fonction to add in the main loop
  void render() {
    if (canMove) 
      walk();
    if (canRotate) 
      turnAround();
    updateCameraData();
    playerCamera.feed();
  }

  //makes sure all the camera info is up to date
  void updateCameraData() {  
    //gets the info from the explorerCam function and sets it to a float array
    float[] camPosition = playerCamera.position();
    float[] camTarget = playerCamera.target();
    playerPosition = new PVector (camPosition[0], camPosition[1], camPosition[2]);
    playerTarget = new PVector (camTarget[0], camTarget[1], camTarget[2]);
  }

  //linear movement forward or backward
  void walk() {
    if (walkDirection != 0) {
      if (walkDone < 25) {
        playerCamera.dolly(walkDirection*(walkDistance/walkStep));
//        playerCamera.track(0.0, 5*sin(-walkBumpAngle));
        walkDone++;
//        walkBumpAngle += walkBumpIncr;
      } else {
        walkDone = 0;
        walkDirection = 0;
        println("reset");
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
        println("reset A");
      }
    }
  }

  //using the W A S D pattern to move the camera around
  void cameraWASD() {
    if (key == 97) rotationAngle = - 0.35;     //A
    if (key == 100) rotationAngle = + 0.35;    //D
    if (key == 119) walkDirection = 1;           //W
    if (key == 115) walkDirection = -1;           //S
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

  float getHeight() {
    return playerHeight;
  }
}

