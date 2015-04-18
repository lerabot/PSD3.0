class GameController {

  boolean isActive;
  boolean newData;

  boolean aState;
  boolean bState;
  boolean cState;
  boolean startState;

  Serial serialPort;
  String serialBuffer;
  String serialData;

  GameController(Serial port, boolean state) {
    serialPort = port;
    isActive = state;
  }

  void updateControllerData() {
    if (isActive) {
      serialBuffer = serialPort.readStringUntil(10);
      if (serialBuffer != null && serialBuffer != serialData) {
        newData = true;
        serialData = serialBuffer;
        print  (serialData);
      } else {
        newData = false;
      }
    }
  }

  boolean boutonA() {
    if (serialData != null) {
      if (serialData.charAt(2) == '0' && aState == false) {
        aState = true;
        return true;
      }
    }
    aState = false;
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
}

