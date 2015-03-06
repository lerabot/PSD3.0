///////////////////////////////////////
//Map related stuff is here
///////////////////////////////////////////

//MAPS///////////////////
Map myPapi;
Map myPapiGarage;
Map myPapiExt;
Map myGourdi;

class Map {
  //ATTRIBUTES
  int mapScale;
  //the map name
  String mapName;
  //setting the model name
  PShape mapModel;
  PShape mapFloorModel;
  PShape mapSkyModel;
  boolean floorDrawn = true;
  boolean hasFloor;
  PShape lastCheckedFace;

  //all the stuff related to the floor and collison detection
  PVector[] floorCorners;
  PVector[] floorCollision = new PVector [1];
  //a counter increase
  int collisionOffset = 0;
  int collisionVectorIndex = 0;

  lcdText[] mapLcdText;

  TempeteNeige laTempete;
  boolean tempeteActive = false;

  //METHODS
  //constructor
  public Map (int mapScale, String mapName) {
    this.mapName = mapName;
    this.mapScale = mapScale;

    if (this.mapName == "Garage") initPapiGarage();
    if (this.mapName == "Ext") initPapiExt();
    if (this.mapName == "Gourdi") initGourdi();
    currentMap = this.mapName;
  }

  /////////////////////////////////////////////////////
  //Check if the camera is on the floor
  /////////////////////////////////////////////////////
  boolean checkFloor() {
    if (mapFloorModel != null) {
      for (int i = 0; i < mapFloorModel.getChildCount (); i++) {
        PShape child = mapFloorModel.getChild(i); 
        //        if (child.getVertexX(0) < -10000 || child.getVertexX(0) < -10000);
        //        println("facepos "+currentShapePosition(child));
        if (thePlayer.getFeet().dist(currentShapePosition(child)) < 1000) println(currentShapePosition(child));
        if (thePlayer.getFeet().dist(currentShapePosition(child)) < 300) {  
          println("facepos "+currentShapePosition(child));
          println("feet pos "+thePlayer.getFeet());
          println("hauteur "+child.getHeight());      
          println("FOUND IT!");
          lastCheckedFace = child;
          return true;
        } else {
        }
      }
    }
    return false;
  }

  PVector currentShapePosition(PShape p) {
    float averageX = (p.getVertexX(0) + p.getVertexX(1) + p.getVertexX(2))/3;
    float averageY =(p.getVertexY(0) + p.getVertexY(1) + p.getVertexY(2))/3;
    float averageZ =(p.getVertexZ(0) + p.getVertexZ(1) + p.getVertexZ(2))/3;
    return new PVector(averageX, averageY, averageZ);
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

    if (mapLcdText != null) {
      for (int i = 0; i < mapLcdText.length; i++) {
        mapLcdText[i].nearTextNoScreen();
      }
    }

    if (tempeteActive) {
      laTempete.showTempete();
    }

    if (lastCheckedFace != null && debug) {
      pushMatrix();
      lastCheckedFace.beginShape();
      lastCheckedFace.fill(255, 0, 0);
      shape(lastCheckedFace);
      lastCheckedFace.endShape(CLOSE);
      popMatrix();
    }
  }

  void initGourdi() {
    mapLcdText = new lcdText[0]; 

    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapModel = loadShape("data/debug.obj"); 
      mapModel.scale(mapScale); 
      mapModel.rotateZ(radians(180)); 
      mapModel.translate(0, 0, 0);
    } else {
      //map proprieties
      //      mapModel = loadShape("data/map2_shop.obj"); 
      //      mapModel.scale(mapScale); 
      //      mapModel.rotateZ(radians(180)); 
      //      mapModel.translate(0, 0, 0); 

      mapFloorModel = loadShape("data/map3/map3.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.rotateZ(radians(180)); 
      mapFloorModel.translate(0, -500, 0);


      //      thePlayer.cameraJump(-2061.4045, -thePlayer.getHeight(), 1016.4433); 
      //      thePlayer.cameraAim(-1149.944, -thePlayer.getHeight(), -763.61993);
    }
    //set the current map name
    thePlayer.isIn(mapName);
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

    mapLcdText = new lcdText[8]; 
    mapLcdText[0] = new lcdText (160.25441, -thePlayer.getHeight(), -3055.5469, 7, "15ans"); 
    mapLcdText[1] = new lcdText (-842.87427, -thePlayer.getHeight(), -1533.1855, 12, "tracteur"); 
    mapLcdText[2] = new lcdText (299.46692, -thePlayer.getHeight(), -4062.8794, 23, "escalier"); 
    mapLcdText[3] = new lcdText (856.384, -thePlayer.getHeight(), -1066.9874, 39, 5000, 45, "moteur1"); 
    mapLcdText[4] = new lcdText (1355.7191, -thePlayer.getHeight(), -1801.152, 33, "tool"); 
    mapLcdText[5] = new lcdText (-2277.8677, -thePlayer.getHeight(), -1182.8413, 28, "sortie", 0.2); 
    mapLcdText[6] = new lcdText (-613.12445, -thePlayer.getHeight(), -4502.5015, 55, "photo", 0.1); 
    mapLcdText[7] = new lcdText (-1776.3018, -thePlayer.getHeight(), -2908.1582, 1, "huilintro", true); 

    thePlayer.cameraJump(-2428.1057, -thePlayer.getHeight(), -1637.1895); 
    thePlayer.cameraAim(-1516.6155, -thePlayer.getHeight(), -3417.4102); 
    //initialize the shape and set it to the position and scale   
    if (debug) {
      mapModel = loadShape("data/debug.obj");
    } else {
      mapModel = loadShape("data/map1/papieGarage31Good.obj");
    }
    mapModel.scale(mapScale);    
    mapModel.rotateZ(radians(180)); 
    mapModel.translate(0, -25, 0);
    //set the current map name
    thePlayer.isIn(mapName);
    println(this.mapName+" loaded");
  }

  //////////////////////////PapiEXT/////////////////////////////
  void initPapiExt() {
    PVector tempeteOrigin = new PVector (2209.1995, -850.03076, -6990.256); 
    laTempete = new TempeteNeige(5000, tempeteOrigin, 20000); 
    tempeteActive = true; 
    mapLcdText = new lcdText[0]; 

    //initialize the shape and set it to the position and scale   
    if (debug) {
      //debug map
      mapFloorModel = loadShape("data/map2/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.rotateZ(radians(180)); 
      mapFloorModel.translate(0, 0, 0);
    } else {
      //map proprieties
      mapModel = loadShape("data/map2/map2_shop.obj"); 
      mapModel.scale(mapScale); 
      mapModel.rotateZ(radians(180)); 
      mapModel.translate(0, 0, 0); 
      println("map2 main loaded");

      mapFloorModel = loadShape("data/map2/map2_shop_floor1.obj"); 
      mapFloorModel.scale(mapScale); 
      mapFloorModel.rotateZ(radians(180)); 
      mapFloorModel.translate(0, 0, 0);
      println("map2 floor loaded");

      mapSkyModel = loadShape("data/map2/map2_shop_ciel.obj"); 
      mapSkyModel.scale(mapScale); 
      mapSkyModel.rotateZ(radians(180)); 
      mapSkyModel.translate(0, 0, 0);
      println("map2 sky loaded");
    }
    thePlayer.cameraJump(-2061.4045, -thePlayer.getHeight(), 1016.4433); 
    thePlayer.cameraAim(-1149.944, -thePlayer.getHeight(), -763.61993);
    //set the current map name
    thePlayer.isIn(mapName);
    println(this.mapName+" loaded");
  }

  //////////////////////////////UTILITY////////////////////////////////////
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

  //a boolean funtion to check the collision
  boolean checkCollision () {
    //needs a floor to happen
    if (hasFloor) {
      //checks through all the collision vector
      for (int i = 0; i < collisionVectorIndex; i++) {
        //if one of these vector is too close to the camera  
        if (floorCollision[i].dist(thePlayer.getPosition()) < 250) {
          //print which one and return true          
          println("Dist"+i+" "+floorCollision[i].dist(thePlayer.getPosition())); 
          return true;
        }
      }
    }
    //if none, just return false
    return false;
  }
}

