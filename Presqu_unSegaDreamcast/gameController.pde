//This classes handles the custom made controller
//it automatly check the serial port for new commands
class GameController {
  //returns if the controller is connected or not
  boolean isActive;
  //keeps track of if new data is sent on said frame
  boolean newData;

  //keeps the state of each button
  boolean aState;
  boolean bState;
  boolean cState;
  boolean startState;

  //a reference of the serial port
  Serial serialPort;
  //this is what is sent through the serial port
  String serialBuffer;
  //this is the last string of sent data
  String serialData;

  //currently testing a bounce feature, this is the delay
  int bounceDelay = 20;
  //keeps track of the last time the data has changes
  int lastDataChange;
 
  boolean controllerReady;

  GameController(Serial port, boolean state) {
    //set the port to the one passed in the arguments
    serialPort = port;
    //sets the active varible
    isActive = state;
  }

  //handles the data coming in the serail port
  void updateControllerData() {
    //only works if the Controller is set to active
    if (isActive) {
      //reads the serial port until a "line feed" appears
      serialBuffer = serialPort.readStringUntil(10);
      //check if the bounce time is right and if new data is sent though the port
      if (lastDataChange + bounceDelay < millis() && serialBuffer != null && serialBuffer != serialData) {
        newData = true;
        //copy what's in the buffer into the Data string
        serialData = serialBuffer;
        //keeps track of the time when the data was sent in
        lastDataChange = millis();
        //for debug prupose, sends the serialData in the port
        print  (serialData);
      } else {
        //if no data is sent, makes sure that the NewData variable is false
        newData = false;
      }
    }
  }

  /////////////////////////////////////
  //BUTTONS
  //all these basicly return a boolean depending on the state 
  //of all the numbers is the String received.
  //each number is a ON/OFF states
  //////////////////////////////////////
  boolean boutonA() {
    //checks if there's data in the serialData string
    if (serialData != null) {
      //check for a particuliar number, and if the last State of this button was false
      if (serialData.charAt(2) == '0' && aState == false) {
        //sets the state of said button to true
        aState = true;
        //since a button has been pressed, the controller can't receive the new data
        controllerReady = false;
        return true;
      }
    }
    //if this button isn't prssed, reset the button state to false
    aState = false;
    //and the controller is ready to receive new data again
    controllerReady = true;
    return false;
  }


  boolean boutonB() {
    if (serialData != null) {
      if (serialData.charAt(6) == '0' && bState == false) {
        bState = true;
        return true;
      }
    }
    bState = false;
    return false;
  }
  boolean boutonC() {
    if (serialData != null) {
      if (serialData.charAt(7) == '0' && cState == false) {
        cState = true;
        return true;
      }
    }
    cState = false;
    return false;
  }
  boolean boutonUp() {
    if (serialData != null) {
      if (serialData.charAt(0) == '0') {
        return true;
      }
    }
    return false;
  }
  boolean boutonDown() {
    if (serialData != null) {
      if (serialData.charAt(1) == '0') {
        return true;
      }
    }
    return false;
  }
  boolean boutonLeft() {
    if (serialData != null) {
      if (serialData.charAt(4) == '0') {
        return true;
      }
    }
    return false;
  }
  boolean boutonRight() {
    if (serialData != null) {
      if (serialData.charAt(5) == '0') {
        return true;
      }
    }
    return false;
  }

  boolean boutonStart() {
    if (serialData != null) {
      if (serialData.charAt(3) == '0' && startState == false) {
        startState = true;
        return true;
      }
    }
    startState = false;
    return false;
  }

  //////////////////////////////////////////
  //ACCESSORS
  /////////////////////////////////////////
  boolean hasNewData() {
    return newData;
  }

  boolean getA_State() {
    return aState;
  }

  boolean getB_State() {
    return bState;
  }

  boolean getC_State() {
    return cState;
  }

  void setControllerReady(boolean state) {
    controllerReady = state;
  }

  boolean isReady() {
    return controllerReady;
  }
}

