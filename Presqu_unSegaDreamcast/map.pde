///////////////////////////////////////
//Map related stuff is here
///////////////////////////////////////////

class Map {
  //ATTRIBUTES
  int mapScale;
  //the map name
  String mapName;
  //setting the model name
  PShape mapModel;
  PShape mapFloorModel;
  PShape mapSkyModel;

  PShape lastCheckedFace;
  PShape nextCheckedFace;

  //all the stuff related to the floor and collison detection
  PVector[] floorCorners;
  PVector[] floorCollision = new PVector [1];
  //a counter increase
  int collisionOffset = 0;
  int collisionVectorIndex = 0;

  ArrayList<lcdText> texts;
  String[] mapText;

  Weather theWeather;
  boolean tempeteActive = false;

  String objective;

  //METHODS
  //constructor
  public Map (int mapScale, String mapName) {
    this.mapName = mapName;
    this.mapScale = mapScale;
    if (this.mapName == "Garage") initPapiGarage();
    if (this.mapName == "Ext") initPapiExt();
    if (this.mapName == "Retour") initPapiRetour();
    if (this.mapName == "Gourdi") initGourdi();
    createText(mapText);
    println("# of text: "+texts.size());
    thePlayer.setMap(this);
  }


  /////////////////////////////////////////////////////////////////////
  ///////////////////////////Shows the current map ///////////////
  ////////////////////////////////////////////////////////////////////
  void show() {

    //display the current model
    if (mapModel != null && !debug) {
      shape(mapModel);
    }

    //for floor model
    if (mapFloorModel != null && !debug) {
      shape(mapFloorModel);
    }

    if (mapSkyModel != null && !debug) {
      shape(mapSkyModel);
    }

    if (texts != null) {
      for (lcdText t : texts) {
        t.checkText();
      }
    }
    //    if (mapFloorModel != null)
    //      showAverage();

    if (tempeteActive && !debug) {
      theWeather.display();
    }

    if (mapName == "Retour") {
      glitchModel(mapModel);
    }




    if (mapName == "Garage") {
      //thePlayer.follow(new PVector(2000, 0, 2000), 3);
    }
    //    showFloorLevel(thePlayer.direction);

    //    if (nextCheckedFace != null) {
    //      drawFace(nextCheckedFace);
    //    }
  }

  void initGourdi() {

    objective = "Où-est Sam?";

    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapModel = loadShape("data/debug.obj"); 
      mapModel.scale(mapScale); 
      mapModel.translate(0, -500, 0);
    } else {
      mapFloorModel = loadShape("data/map3/map3.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.translate(0, -500, 0);
    }
    thePlayer.cameraJump(1341.1835, -thePlayer.getHeight(), 2589.0117); 
    thePlayer.cameraAim(2244.692, -thePlayer.getHeight(), 804.9005);
    //set the current map name
    mapText = loadStrings("map3/map3_text.txt");
    println(this.mapName+" loaded");
  }

  //////////////////////////PapiGARAGE/////////////////////////////
  void initPapiGarage() {
    floorCorners = new PVector [7]; 
    //set up the floor as a collision object    
    floorCorners[0] = new PVector (-3084.667, -thePlayer.getHeight(), -1021.6255); 
    floorCorners[1] = new PVector (1722.3079, -850.00256, -806.89954); 
    floorCorners[2] = new PVector (1684.7804, -850.00024, -2875.14); 
    floorCorners[3] = new PVector (790.49896, -850.0002, -3563.4263); 
    floorCorners[4] = new PVector (645.8008, -850.00037, -4738.9956); 
    floorCorners[5] = new PVector (-2605.3396, -850.00037, -4892.056); 
    floorCorners[6] = new PVector (-3084.667, -849.9998, -1021.6255); 

    //function that compute where the collision shoud occur and the accuracy
    computeCollisionVector(15); 

    objective = "Explore the area";

    thePlayer.cameraJump(-2399.593, -86.96228, 1492.4738); 
    thePlayer.cameraAim(-2007.3064, -82.30486, 3453.619); 
    //initialize the shape and set it to the position and scale   
    if (debug) {
      mapModel = loadShape("data/debug.obj");
    } else {
      mapModel = loadShape("data/map1/papieGarage31Good.obj");
    }
    mapModel.scale(mapScale);    
    mapModel.translate(0, -25, 0);
    //set the current map name
    mapText = loadStrings("map1/map1_text.txt");
    println(this.mapName+" loaded");
  }

  //////////////////////////PapiEXT/////////////////////////////
  void initPapiExt() {
    PVector tempeteOrigin = new PVector (947.44763, -850.71443, 4120.506); 
    theWeather = new Weather(tempeteOrigin, 50000, 3000, "snow"); 
    tempeteActive = true; 

    objective = "Get into the workshop";

    mapText = loadStrings("map2/map2_text.txt");

    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapFloorModel = loadShape("data/map2/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.translate(0, 0, 0);
    } else {
      //map proprieties
      mapModel = loadShape("data/map2/map2_shop.obj"); 
      mapModel.scale(mapScale); 
      mapModel.translate(0, 0, 0); 
      println("map2 main loaded");

      mapFloorModel = loadShape("data/map2/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.translate(0, 0, 0);
      println("map2 floor loaded");

      mapSkyModel = loadShape("data/map2/map2_shop_ciel.obj"); 
      mapSkyModel.scale(mapScale);  
      mapSkyModel.translate(0, 0, 0);
      println("map2 sky loaded");
    }
    thePlayer.cameraJump(-15790.673, -94.43428, -2025.185); 
    thePlayer.cameraAim(-13873.002, -95.42826, -1457.8029);
    //set the current map name
    println(this.mapName+" loaded");
  }

  //////////////////////////Le retour/////////////////////////////
  void initPapiRetour() {
    PVector tempeteOrigin = new PVector (947.44763, -850.71443, 4120.506); 
    theWeather = new Weather(tempeteOrigin, 20000, 5000, "both"); 
    tempeteActive = true; 


    mapText = loadStrings("map4/map2_text.txt");

    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapFloorModel = loadShape("data/map4/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.translate(0, 0, 0);
    } else {
      //map proprieties
      mapModel = loadShape("data/map4/map4_shop.obj"); 
      mapModel.scale(mapScale); 
      mapModel.translate(0, 0, 0); 

      mapFloorModel = loadShape("data/map4/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.translate(0, 0, 0);

      mapSkyModel = loadShape("data/map4/map2_shop_ciel.obj"); 
      mapSkyModel.scale(mapScale);  
      mapSkyModel.translate(0, 0, 0);
    }
    
    thePlayer.cameraJump(-21073.932, -92.21912, -2480.2827); 
    thePlayer.cameraAim(-19152.072, -91.83776, -1927.2524);

    //set the current map name
    println(this.mapName+" loaded");
  }

  /////////////////////////////////////////////////////
  //Check if the camera is on the floor
  /////////////////////////////////////////////////////

  void drawFace(PShape child) {
    lastCheckedFace.beginShape();
    shape(lastCheckedFace);
    lastCheckedFace.endShape(CLOSE);
  }

  boolean checkFloor() {
    if (mapFloorModel != null) {
      for (int i = 0; i < mapFloorModel.getChildCount (); i++) {
        PShape child = mapFloorModel.getChild(i); 
        //        for (int j = 0; j < 7; j++) {
        if (thePlayer.getFeet().dist(currentShapePosition(child)) < 1500) {  
          //          println("FACE: "+currentShapePosition(child));
          //          println("FEET: "+thePlayer.getFeet());
          //          println("HEIGHT: "+child.getHeight());      
          //          println("DIST: "+ thePlayer.getFeet().dist(currentShapePosition(child)));
          lastCheckedFace = child;
          return true;
        } else {
        }
        //        }
      }
    }
    return false;
  }

  float getFloorLevel(int direction) {
    //needs a floormodel to work
    if (mapFloorModel != null) {
      //check every child of the model
      for (int i = 0; i < mapFloorModel.getChildCount (); i++) {
        PShape child = mapFloorModel.getChild(i);
        //if a lerp of the player at walking distance find a geometry, use this as reference 
        if (thePlayer.playerLerp(direction).dist(currentShapePosition(child)) < 400) {
          if (thePlayer.getPosition().dist(currentShapePosition(child)) > 500) {
            nextCheckedFace = child;
            return currentShapePosition(nextCheckedFace).y;
          }
        }
      }
    }
    return 0;
  }

  void showFloorLevel(int direction) {
    //needs a floormodel to work
    if (mapFloorModel != null) {
      //check every child of the model
      for (int i = 0; i < mapFloorModel.getChildCount (); i++) {
        PShape child = mapFloorModel.getChild(i);
        //if a lerp of the player at walking distance find a geometry, use this as reference 
        if (thePlayer.playerLerp(direction).dist(currentShapePosition(child)) < 1500) {
          if (thePlayer.getPosition().dist(currentShapePosition(child)) > 0) {
            nextCheckedFace = child;
            println("FLKJSDALKJ");
          }
        }
      }
      println("SHIT");
    }
  }

  PVector currentShapePosition(PShape p) {
    float averageX = (p.getVertexX(0) + p.getVertexX(1) + p.getVertexX(2)) /3.0;
    float averageY = (p.getVertexY(0) + p.getVertexY(1) + p.getVertexY(2)) /3.0;
    float averageZ = (p.getVertexZ(0) + p.getVertexZ(1) + p.getVertexZ(2)) /3.0;
    PVector averagePos = new PVector(averageX, averageY, averageZ);
    averagePos.mult(mapScale);
    return averagePos;
  }


  /////////////////////////////VERTEX STUFF////////////////////////////////

  void glitchModel (PShape model) {
    int totalFaces = model.getChildCount();
    PVector direction = PVector.random3D();
    direction.setMag(random(50, 6000));

    //    if (millis() % int(random(1000, 7000)) < 30) {
    //      println("glitch");
    //      int areaToEffect = int(random(1, totalFaces));
    //      int areaSize = 1;
    //      for (int i = 0; i < areaSize; i++) {
    //        int faceNumber = int(random(areaToEffect - areaSize, areaToEffect + areaSize));
    //        hideVertex(constrain(faceNumber, 1, totalFaces-1), mapModel);
    //      }
    //    }

    if (millis() % int(random(300, 4000)) < 30) {
      println("move");
      int areaToEffect = int(random(1, totalFaces));
      int areaSize = 500;
      for (int i = 0; i < areaSize; i++) {
        int faceNumber = int(random(areaToEffect - areaSize, areaToEffect + areaSize));
        moveVertex(constrain(faceNumber, 1, totalFaces-1), mapModel, direction);
      }
    }
  }

  //hide a vertex depending on his state
  void hideVertex(int index, PShape theModel) {
    //checking the state
    if (theModel.getChild(index).getKind() != 0) {
      //hiding
      theModel.getChild(index).setKind(0);
    } else { 
      //un-hiding
      theModel.getChild(index).setKind(TRIANGLE);
    }
    //for some reason, if you don't "set" the vertex, nothing happens...
    theModel.getChild(index).setVertex(1, theModel.getChild(index).getVertexX(1), theModel.getChild(index).getVertexY(1), theModel.getChild(index).getVertexZ(1));
  }

  //make a vertex seeable
  void showVertex(int index, PShape theModel) {
    theModel.getChild(index).setKind(TRIANGLE); 
    theModel.getChild(index).setVertex(1, theModel.getChild(index).getVertexX(1), theModel.getChild(index).getVertexY(1), theModel.getChild(index).getVertexZ(1));
  }

  //move a vertex
  void moveVertex(int index, PShape theModel, PVector direction) {
    theModel.getChild(index).setKind(TRIANGLE); 

    theModel.getChild(index).setVertex(0, 
    theModel.getChild(index).getVertexX(0)+direction.x, 
    theModel.getChild(index).getVertexY(0)+direction.y, 
    theModel.getChild(index).getVertexZ(0)+direction.z);

    theModel.getChild(index).setVertex(1, 
    theModel.getChild(index).getVertexX(1)+direction.x, 
    theModel.getChild(index).getVertexY(1)+direction.y, 
    theModel.getChild(index).getVertexZ(1)+direction.z);

    theModel.getChild(index).setVertex(2, 
    theModel.getChild(index).getVertexX(2)+direction.x, 
    theModel.getChild(index).getVertexY(2)+direction.y, 
    theModel.getChild(index).getVertexZ(2)+direction.z);
  }


  //////////////////////////////UTILITY////////////////////////////////////

  String getMapName() {
    if (mapName != null) {
      return mapName;
    }
     else {
      return "N/A";
    }
  }

  String getObjective() {
    if (objective != null) {
      return objective;
    } else {
      return "N/A";
    }
  }


  //this function read the mapText file and create all the needed lcdText objects
  void createText(String textfile[]) {
    //initialize the arrayText
    texts = new ArrayList<lcdText>();
    //goes throught every line of the .txt file
    for (int i = 0; i < textfile.length; i++) {
      //check if the line isn't blank
      if (textfile[i].length() != 0) {
        //checks if the first char is #, which marks a new block of text
        if (textfile[i].charAt(0) == '#') {
          String getName = textfile[i].substring(2);
          //splits the second line in 3, since it contain the position of each text
          String[] getPosition = split(textfile[i+1], ',');
          Boolean locationBased;
          PVector textPosition = new PVector (0, 0, 0);
          if (getPosition.length == 3) {
            //assings these position to a new PVector if there's a position
            textPosition.set(float(getPosition[0]), -thePlayer.getHeight(), float(getPosition[2]));
            locationBased = true;
          } else {
            //if there's less, this mean that the text isn't meant to be triggered by position
            textPosition.set(0, -5000, 0);
            locationBased = false;
          }
          //fills a string with the text content
          ArrayList<String> theText = new ArrayList<String>();
          boolean longText = false;
          for (int j = 0; j < 20; j++) {
            int lineToAdd = i+2+j;
            if (textfile[lineToAdd].length() != 0) {
              theText.add(textfile[lineToAdd]);
              if (j > 4) {
                longText = true;
              }
            } else {
              j = 20;
            }
          }
          //create a text 
          texts.add(new lcdText(textPosition, i+2, getName, theText, locationBased, longText));
        }
      }
    }
  }

  void showAverage() {
    for (int i = 0; i < mapFloorModel.getChildCount (); i++) {
      PShape child = mapFloorModel.getChild(i);
      if (i % 3 == 0) 
        showTarget(currentShapePosition(child).x, currentShapePosition(child).y, currentShapePosition(child).z);
    }
  }


  //create collision vectors if it has a floor
  void computeCollisionVector(int precision) {
    //checks if said map has a floor
    if (mapFloorModel != null) {
      //calculate the number of collision vertex to be created in relation ship to the number of borders and precision
      collisionVectorIndex = precision * (floorCorners.length-1); 
      floorCollision = new PVector [collisionVectorIndex]; 
      //goes through all the edges of the floor
      for (int i = 0; i < floorCorners.length-1; i++) {
        //sets an origin
        PVector current = new PVector (0, 0, 0); 
        //and a destination
        PVector target = new PVector (0, 0, 0); 
        // assigns a floor corner to the origin     
        current.set(floorCorners[i]); 
        // and assign a nother floor corner to the destination
        target.set(floorCorners[i+1]); 

        //goes from the origin to the destination and devides the vertex lenght byt the precision amount
        for (int j = 0; j < precision; j++) {
          floorCollision[j+collisionOffset] = PVector.lerp(current, target, j*0.1);
        }    
        //continues to index the floorCollisions even if there's a new line
        collisionOffset = collisionOffset + precision;
      }
    }    
    println(mapName + collisionVectorIndex);
  }

  //  //a boolean funtion to check the collision
  //  boolean checkCollision () {
  //    //needs a floor to happen
  //      //checks through all the collision vector
  //      for (int i = 0; i < collisionVectorIndex; i++) {
  //        //if one of these vector is too close to the camera  
  //        if (floorCollision[i].dist(thePlayer.getPosition()) < 250) {
  //          //print which one and return true          
  //          println("Dist"+i+" "+floorCollision[i].dist(thePlayer.getPosition())); 
  //          return true;
  //        }
  //      }
  //    }
  //    //if none, just return false
  //    return false;
  //  }
}

