///////////////////////////////////////
//Map related stuff is here
///////////////////////////////////////////

class Map {
  //ATTRIBUTES
  //the map model scale factor
  int mapScale;
  //the map name
  String mapName;
  //holds the different model that compose each map
  PShape mapModel;
  PShape mapFloorModel;
  PShape mapSkyModel;

  //mostly used for collision detection, which is currently on hold
  PShape lastCheckedFace;
  PShape nextCheckedFace;

  //a counter increase
  int collisionOffset = 0;
  int collisionVectorIndex = 0;

  //holds all the LCD text Objects
  ArrayList<lcdText> texts;
  //this is the text files every maps has, it holds all the data to make LCDtext objects
  String[] mapText;

  //Adds a weather system per map, used for snow or fog
  Weather theWeather;
  //is the weather active?
  boolean tempeteActive = false;

  //a siple string that holds the map objective to display in the GUI
  String objective;
  //maximum time in map before it teleports you away (IN SECONDS)
  int maxTimeInMap;

  //constructor takes the map name and the level in the progression
  public Map (String mapName, int mapIndex) {
    //save the name
    this.mapName = mapName;
    //calls a different function to load a map depending on the mapName
    if (mapName.equals("Garage")) initPapiGarage();
    if (mapName.equals("Ext")) initPapiExt();
    if (mapName.equals("Retour")) initPapiRetour();
    if (mapName.equals("Gourdi")) initGourdi();
    //create LCDtext objects with the MapText file each map has 
    createText(mapText);
    //prints how many text the map has
    println("# of text: "+texts.size());
    //set the player map as Active
    thePlayer.setMap(this, mapIndex);
  }


  /////////////////////////////////////////////////////////////////////
  ///////////////////////////Shows the current map ///////////////
  ////////////////////////////////////////////////////////////////////

  //main function to draw the map on the screen
  void show() {



    //display the current model
    if (mapModel != null && !debug) {
      shape(mapModel);
    }

    //display the floor model
    if (mapFloorModel != null && !debug) {
      shape(mapFloorModel);
    }

    //displays the skyp model
    if (mapSkyModel != null && !debug) {
      shape(mapSkyModel);
    }
    
    //
    noLights();
    if (texts != null) {
      for (lcdText t : texts) {
        t.checkText();
      }
    }

    if (tempeteActive && !debug) {
      theWeather.display();
    }

    if (mapName.equals("Gourdi")) {
      flashLight();
    }
    //    if (mapFloorModel != null)
    //      showAverage();


    if (mapName.equals("Retour") && mapModel != null) {
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


  //////////////////////////GOURDI/////////////////////////////
  void initGourdi() {

    objective = "Où-est Sam?";
    maxTimeInMap = 240;
    mapScale = -1;

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

    objective = "Explore the area";
    maxTimeInMap = 150;
    mapScale = -30;

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

    maxTimeInMap = 240;
    objective = "Get into the workshop";

    mapText = loadStrings("map2/map2_text.txt");
    mapScale = -3;

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
    PVector tempeteOrigin = new PVector (-16970.201, -91.05798, -1821.0582); 
    theWeather = new Weather(tempeteOrigin, 20000, 3000, "both"); 
    tempeteActive = true; 

    maxTimeInMap = 240;
    mapScale = -3;

    mapText = loadStrings("map4/map4_text.txt");

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

    if (millis() % int(random(1000, 5000)) < 30) {
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

  int getMaxTimeInMap() {
    return maxTimeInMap * 1000;
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
            textPosition.set(0, 5000, 0);
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

  //shows a visual representation of the middle of a face
  void showAverage() {
    //iterate the loop for every face of the mapFloormodel
    for (int i = 0; i < mapFloorModel.getChildCount (); i++) {
      //get a shape a current index
      PShape child = mapFloorModel.getChild(i);
      //uses the ShowTarget function to display a shpere 
      showTarget(currentShapePosition(child).x, currentShapePosition(child).y, currentShapePosition(child).z);
    }
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

