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
  //the posisiton of every model of a map
  PVector mapPosition;

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
  boolean weatherActive = false;

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

    //if there are text in the maps
    if (texts != null) {
      //goes through all the text 
      for (lcdText t : texts) {
        //and check if you're in range to active the text!
        t.checkText();
      }
    }

    //if the maps as a WEATHER system and its not in debug mode,
    if (weatherActive && !debug) {
      //show the weather
      theWeather.display();
    }

    //MAP EXCLUSIVE FUNCTION
    if (mapName.equals("Gourdi")) {
      //adds the flash light effect
      flashLight();
    }

    //MAP EXCLUSIVE FUNCTION
    //this one needs the mapModel to works 
    if (mapName.equals("Retour") && mapModel != null) {
      //progressivly destroy the maps
      glitchModel(mapModel);
    }

    ////////////////////////////////////////////////////////////
    //FUNCTION RELATED TO COLLISION DETECTION
    //NO IMPLEMENTED OR ANYTHING
    ////////////////////////////////////////////////////////////

    //    showFloorLevel(thePlayer.direction);

    //    if (nextCheckedFace != null) {
    //      drawFace(nextCheckedFace);
    //    }

    //NOT IMPLEMENTED YET, some function that shows the center of each face in the MAP FLOOD MODEL
    //    if (mapFloorModel != null)
    //      showAverage();
  }

  ////////////////////////////////////////////////////////////
  //MAPS CREATING FUNCTION
  //i'll only comment what is new since there's alot of repeating here!
  //in the future i'm going to make a function that load the map setting coording to a text file
  //////////////////////////////////////////////////////////////

  //////////////////////////GOURDI/////////////////////////////
  void initGourdi() {
    //set the map objective to be written by the small information box in the GUI
    objective = "Où-est Sam?";
    //loads the map text into a array of strings
    mapText = loadStrings("map3/map3_text.txt");
    //maximum time allowed in this map
    maxTimeInMap = 240;
    //scale factor of the different map models
    mapScale = -1;
    //set the map position wher it should be
    mapPosition = new PVector (0, -500, 0);
    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapModel = loadShape("data/debug.obj"); 
      //scales the map by it's scale factor
      mapModel.scale(mapScale); 
      //translate the map at this position
      mapModel.translate(mapPosition.x, mapPosition.y, mapPosition.z);
    } else {
      mapFloorModel = loadShape("data/map3/map3.obj"); 
      mapFloorModel.scale(mapScale); 
      mapModel.translate(mapPosition.x, mapPosition.y, mapPosition.z);
    }
    //place the player at the starting position
    thePlayer.cameraJump(1341.1835, -thePlayer.getHeight(), 2589.0117); 
    //aims in the right direction
    thePlayer.cameraAim(2244.692, -thePlayer.getHeight(), 804.9005);
    println(this.mapName+" loaded");
  }

  //////////////////////////PapiGARAGE/////////////////////////////
  void initPapiGarage() {

    objective = "Explore the area";
    maxTimeInMap = 150;
    mapScale = -30;

    //initialize the shape and set it to the position and scale  
    mapPosition = new PVector (0, -25, 0); 
    if (debug) {
      mapModel = loadShape("data/debug.obj");
    } else {
      mapModel = loadShape("data/map1/papieGarage31Good.obj");
      mapModel.scale(mapScale);
      mapModel.translate(mapPosition.x, mapPosition.y, mapPosition.z);
    }

    thePlayer.cameraJump(-2399.593, -86.96228, 1492.4738); 
    thePlayer.cameraAim(-2007.3064, -82.30486, 3453.619); 
    //set the current map name
    mapText = loadStrings("map1/map1_text.txt");
    println(this.mapName+" loaded");
  }

  //////////////////////////PapiEXT/////////////////////////////
  void initPapiExt() {
    //create a PVector for the center of the storm
    PVector tempeteOrigin = new PVector (947.44763, -850.71443, 4120.506); 
    //create a weather system with the origin of the System, the area size 
    //and the number of particule along with the type of weather
    theWeather = new Weather(tempeteOrigin, 50000, 3000, "snow"); 
    //sets the weather to active
    weatherActive = true; 

    objective = "Get into the workshop";
    mapText = loadStrings("map2/map2_text.txt");
    maxTimeInMap = 240;
    mapScale = -3;

    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapFloorModel = loadShape("data/map2/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale);
    } else {
      //map proprieties
      mapModel = loadShape("data/map2/map2_shop.obj"); 
      mapModel.scale(mapScale); 

      mapFloorModel = loadShape("data/map2/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 

      mapSkyModel = loadShape("data/map2/map2_shop_ciel.obj"); 
      mapSkyModel.scale(mapScale);
    }
    thePlayer.cameraJump(-15790.673, -94.43428, -2025.185); 
    thePlayer.cameraAim(-13873.002, -95.42826, -1457.8029);

    println(this.mapName+" loaded");
  }

  //////////////////////////Le retour/////////////////////////////
  void initPapiRetour() {
    PVector tempeteOrigin = new PVector (-16970.201, -91.05798, -1821.0582); 
    theWeather = new Weather(tempeteOrigin, 20000, 3000, "both"); 
    weatherActive = true; 

    maxTimeInMap = 240;
    mapScale = -3;
    mapText = loadStrings("map4/map4_text.txt");

    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapFloorModel = loadShape("data/map4/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale);
    } else {
      //map proprieties
      //main model object
      mapModel = loadShape("data/map4/map4_shop.obj"); 
      mapModel.scale(mapScale);  
      //the floor model
      mapFloorModel = loadShape("data/map4/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 
      //the sky model
      mapSkyModel = loadShape("data/map4/map2_shop_ciel.obj"); 
      mapSkyModel.scale(mapScale);
    }
    thePlayer.cameraJump(-21073.932, -92.21912, -2480.2827); 
    thePlayer.cameraAim(-19152.072, -91.83776, -1927.2524);

    println(this.mapName+" loaded");
  }

  /////////////////////////////////////////////////////
  //COLLISION DETECTION FUNCTION
  //NOT IMPLEMENTED, WILL NOT LOOSE TIME WITH THIS ANYMORE
  //SORRY
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


  /////////////////////////////VERTEX + FACES STUFF////////////////////////////////

  //takes random faces and pushes them in a direction
  void glitchModel (PShape model) {
    //gets the total number of faces the model has
    int totalFaces = model.getChildCount();
    //create a random PVector in 3d, and set it magnitude to a random number
    PVector direction = PVector.random3D();
    direction.setMag(random(50, 6000));

    //this mathematical function basicly give a random "pulse" effect to the function
    if (millis() % int(random(1000, 5000)) < 30) {
      // select a number between 1 and the total number of face as a refenrece
      int areaToEffect = int(random(1, totalFaces));
      //this could change, but is basicle the number of faces affected by the "glitch" effect
      final int areaSize = 500;
      //iterates through the area Size
      for (int i = 0; i < areaSize; i++) {
        //select a random face around the areaToEffect 
        int faceNumber = int(random(areaToEffect - areaSize, areaToEffect + areaSize));
        //and moves this face away using the direction PVector up there
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
    //sets the vertex back to atriangle (so it is seeable)
    theModel.getChild(index).setKind(TRIANGLE); 
    //for some reason, if you don't "set" the vertex, nothing happens...
    theModel.getChild(index).setVertex(1, theModel.getChild(index).getVertexX(1), theModel.getChild(index).getVertexY(1), theModel.getChild(index).getVertexZ(1));
  }

  //move a vertex, needs a model, an index face number and a direction
  void moveVertex(int index, PShape theModel, PVector direction) {
    //makes sure the face is seeable
    theModel.getChild(index).setKind(TRIANGLE); 
    //SUPER LONG FUNCTION, BASICLY SETS EVERY VERTEX AT AN X,Y,Z POSITION
    //VERTEX 0
    theModel.getChild(index).setVertex(0, 
    theModel.getChild(index).getVertexX(0)+direction.x, 
    theModel.getChild(index).getVertexY(0)+direction.y, 
    theModel.getChild(index).getVertexZ(0)+direction.z);
    //VERTEX 1
    theModel.getChild(index).setVertex(1, 
    theModel.getChild(index).getVertexX(1)+direction.x, 
    theModel.getChild(index).getVertexY(1)+direction.y, 
    theModel.getChild(index).getVertexZ(1)+direction.z);
    //VERTEX 2
    theModel.getChild(index).setVertex(2, 
    theModel.getChild(index).getVertexX(2)+direction.x, 
    theModel.getChild(index).getVertexY(2)+direction.y, 
    theModel.getChild(index).getVertexZ(2)+direction.z);
  }


  //////////////////////////////UTILITY////////////////////////////////////
  //returns the map name
  String getMapName() {
    if (mapName != null) {
      return mapName;
    }
    //if there's no map name, returns a N/A string
     else {
      return "N/A";
    }
  }

  //returns the maximum time in SECOND the player can spend in the map
  int getMaxTimeInMap() {
    return maxTimeInMap * 1000;
  }

  //returns the objective of the map
  String getObjective() {
    if (objective != null) {
      return objective;
    } else {
      //if there's no objective, returns N/A
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
          //defaults the long text to false
          boolean longText = false;
          //iterates 20 time, in case of long texts
          for (int j = 0; j < 20; j++) {
            //add the second line from where the text as been localized
            int lineToAdd = i+2+j;
            //only add a line if the string is longer than 0 char
            if (textfile[lineToAdd].length() != 0) {
              theText.add(textfile[lineToAdd]);
              //if there's more thans 4 lines of text, it is a long text
              if (j > 4) {
                longText = true;
              }
              //if a line return to 0 char, stop the for loop
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
}

