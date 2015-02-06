/////////////////////////////////////
//Tout ce qui est relatif à la camera est ici
/////////////////////////////////////

////////////////Updates the camera data everywhere/////

void updateCameraData() {  
  //gets the info from the explorerCam function and sets it to a float array
  camTarget = explorerCam.target();
  camPosition = explorerCam.position();
  PVcamPosition.set(camPosition[0], camPosition[1], camPosition[2]);
  PVcamTarget.set(camTarget[0], camTarget[1], camTarget[2]); 
}

//////////FOWARD / BACKWARD MOVEMENT////////////////
void cameraMovement() {
  //if you move
  if (footstep != 0) {
    //some sort of counter to have a walking animation
    if (stepDone < stepTime) {      
      explorerCam.dolly(footstep/stepTime);
      explorerCam.track(0.0, sin(-walkingBumpIncr)*5);
      stepDone++;
      walkingBumpIncr = walkingBumpIncr + walkingBumpAngle;
    } else 
      //once the animation is complete, reset the counter and the number of steps
    {
      stepDone = 0;
      footstep = 0;
    }
  }
}


////////////ROTATION MOUVEMENT////s///////////////////
void cameraRotation() {
  //check the rotation Angle for a value change
  if (rotationAngle != 0) {
    //since the operation happens overtime, it check where the index for its current poisition
    if (rotationDone < rotationTime) {
      //simple operation ot divide therotation angle over time
      explorerCam.pan(rotationAngle/rotationTime);
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

/////////////////////////////////////////////////////////


//using the W A S D pattern to move the camera around
void cameraWASD() {
  if (key == 97) rotationAngle = - 0.35;     //A
  if (key == 100) rotationAngle = + 0.35;    //D
  if (key == 119) footstep = -300;           //W
  if (key == 115) footstep = +300;           //S
}

//using the mouse to orient the camera around
//void mouseMoved() {
//  tumbleX = radians(mouseX-pmouseX);
//  tumbleY = radians(mouseY-pmouseY);
//  explorerCam.pan(tumbleX);
//  explorerCam.tilt(tumbleY);
//} 


//a way to get the camera orientation and position, mostly for debig purpose
void mouseClicked() {
  println("TARGET "+camTarget[0]+", "+camTarget[1]+", "+camTarget[2]);
  println("POSITION "+camPosition[0]+", "+camPosition[1]+", "+camPosition[2]);
} 


//set the control for the item changes
void itemList() {
//if the I key is pressed
  if (key == 105) {
    //increment the intemIndex 
    itemIndex++;
    //send it to the serial port
    serialPort.write("o\n");
    //send it to debug
    println(itemIndex);
  }
  //only allow this is you're over 0
  if (itemIndex > 0) {
    //if O is pressed
    if (key == 111) {
      //decrement the index
     itemIndex--;
     //send to serial
    serialPort.write("i\n");
    println(itemIndex);
    }
  }
}

float cameraNormal() {
 return  PVector.angleBetween(PVcamPosition, PVcamTarget);  
}

