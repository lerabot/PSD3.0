/////////////////////////////////////
//Tout ce qui est relatif à la camera est ici
/////////////////////////////////////



//using the mouse to orient the camera around
//void mouseMoved() {
//  tumbleX = radians(mouseX-pmouseX);
//  tumbleY = radians(mouseY-pmouseY);
//  explorerCam.pan(tumbleX);
//  explorerCam.tilt(tumbleY);
//} 





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
 return  PVector.angleBetween(thePlayer.getPosition(), thePlayer.getTarget());  
}

