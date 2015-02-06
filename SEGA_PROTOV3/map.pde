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

  boolean hasFloor = false;
  boolean floorDrawn = true;

  //all the stuff related to the floor and collison detection
  PVector[] floorCorners;
  PVector[] floorCollision = new PVector [1];
  //a counter increase
  int collisionOffset = 0;
  int collisionVectorIndex = 0;

  lcdText[] mapLcdText;

  //METHODS
  //constructor
  public Map (int mapScale, String mapName) {
    this.mapName = mapName;
    this.mapScale = mapScale;

    if (this.mapName == "L'arcade") initArcade();
    if (this.mapName == "Le Garage") initGarage();
    if (this.mapName == "papi") initPapi();
    if (this.mapName == "Chez Jeannot") initPapiGarage();
    if (this.mapName == "Ext") initPapiExt();
  }


  /////////////////////////////////////////////////////////////////////
  ///////////////////////////Shows the current map ///////////////
  ////////////////////////////////////////////////////////////////////
  void show() {
    mapLights();
    if (checkCollision()) {
      //instantly reverse the movement
      explorerCam.dolly(-footstep);
      //sets the variables to 0 and update the camera data too.
      footstep = 0;
      stepDone= 0;
    }
    //display the current model
    shape(mapModel);
    for (int i = 0; i < mapLcdText.length; i++) {
      mapLcdText[i].nearText();
    }
    if (debug && hasFloor) {

      drawFloor();
    }
  }


  //////////////////////////Papi/////////////////////////////
  void initPapi() {
    //    floorCorners = new PVector [7];
    //    //set up the floor as a collision object    
    //    floorCorners[0] = new PVector (-5302.0854, 1000 + explorerHeight, 1848.8485);
    //    floorCorners[1] = new PVector ( -6125.0347, 1000 + explorerHeight, -405.64435);
    //    floorCorners[2] = new PVector ( -738.818, 1000.0001 + explorerHeight, -4013.489);
    //    floorCorners[3] = new PVector ( -338.818, 1000.0001 + explorerHeight, -3213.489);    
    //    floorCorners[4] = new PVector ( 2812.7913, 999.9821 + explorerHeight, -5016.7556);
    //    floorCorners[5] = new PVector ( 2894.0137, 999.97473 + explorerHeight, -1634.4142); 
    //    floorCorners[6] = new PVector (-5302.0854, 1000 + explorerHeight, 1848.8485);
    //    hasFloor = true;
    //    //function that compute where the collision shoud occur and the accuracy
    //    computeCollisionVector(15);



    //        explorerCam.jump(-961.0233, -1.0442734E-4, 1414.5048);
    //        explorerCam.aim(-2928.9976, -1.9185012E-4, 1770.9828);
    //initialize the shape and set it to the position and scale    
    mapModel = loadShape("data/papiInside100kDOUBLÉTEXTURE.obj");
    mapModel.translate(0, 0, 0);
    mapModel.scale(mapScale);
    mapModel.rotateX(radians(90));
    //    mapModel.rotateZ(radians(180));
    //set the current map name
    currentMap = mapName;
    println(this.mapName+" loaded");
  }

  //////////////////////////PapiGARAGE/////////////////////////////
  void initPapiGarage() {
    floorCorners = new PVector [7];
    //set up the floor as a collision object    
    floorCorners[0] = new PVector (-3084.667, -849.9998, -1021.6255);
    floorCorners[1] = new PVector (1722.3079, -850.00256, -806.89954);
    floorCorners[2] = new PVector (1684.7804, -850.00024, -2875.14);
    floorCorners[3] = new PVector (790.49896, -850.0002, -3563.4263);    
    floorCorners[4] = new PVector (645.8008, -850.00037, -4738.9956);
    floorCorners[5] = new PVector (-2605.3396, -850.00037, -4892.056); 
    floorCorners[6] = new PVector (-3084.667, -849.9998, -1021.6255);
    hasFloor = true;
    //function that compute where the collision shoud occur and the accuracy
    computeCollisionVector(15);

    for (int i = 0; i < maNeige.length; i++) {
      maNeige[i] = new Neige(random(-4000, 2000), random(-3000, 50), random(-5000, -1000), vent);
    }


    mapLcdText = new lcdText[8];
    mapLcdText[0] = new lcdText (160.25441, -850.00543, -3055.5469, 7, "15ans"); 
    mapLcdText[1] = new lcdText (-842.87427, -850.00055, -1533.1855, 12, "tracteur"); 
    mapLcdText[2] = new lcdText (299.46692, -880.4774, -4062.8794, 23, "escalier"); 
    mapLcdText[3] = new lcdText (856.384, -850.00006, -1066.9874, 39, 5000, 45, "moteur1");
    mapLcdText[4] = new lcdText (1355.7191, -849.99994, -1801.152, 33, "tool"); 
    mapLcdText[5] = new lcdText (-2277.8677, -850.00024, -1182.8413, 28, "sortie", 0.2); 
    mapLcdText[6] = new lcdText (-613.12445, -853.6523, -4502.5015, 55, "photo", 0.1);
    mapLcdText[7] = new lcdText (-1776.3018, -850.0, -2908.1582, 1, "huilintro", true);  



    explorerCam.jump(-2428.1057, -explorerHeight, -1637.1895);
    explorerCam.aim(-1516.6155, -explorerHeight, -3417.4102);
    //initialize the shape and set it to the position and scale   
    if (debug) {
      mapModel = loadShape("data/debug.obj");
    } else {
      mapModel = loadShape("data/papieGarage31Good.obj");
    }
    mapModel.scale(mapScale);
    mapModel.rotateZ(radians(180));
    //set the current map name
    currentMap = mapName;
    println(this.mapName+" loaded");
  }

  //////////////////////////PapiEXT/////////////////////////////
  void initPapiExt() {
    for (int i = 0; i < maNeige.length; i++) {
      maNeige[i] = new Neige(random(-8000, 8000), random(-8000, -400), random(0, 8500), vent);
    }

    mapLcdText = new lcdText[0];

    explorerCam.jump(-7120.359, -0.007692218, 10896.645);
    explorerCam.aim(-5653.737, -0.007776141, 9536.98);
    //initialize the shape and set it to the position and scale   
    if (debug) {
      mapModel = loadShape("data/debug.obj");
      mapModel.translate(-7120.359, -0.007692218, 10896.645);
    } else {
      mapModel = loadShape("data/papiExt72TEST.obj");
    }
    mapModel.scale(mapScale);
    mapModel.rotateZ(radians(180));
    mapModel.translate(0, -100, 0);
    //set the current map name
    currentMap = mapName;
    println(this.mapName+" loaded");
  }






  //////////////////////////GARAGE/////////////////////////////
  void initGarage() {
    //    floorCorners = new PVector [7];
    //    //set up the floor as a collision object    
    //    floorCorners[0] = new PVector (-5302.0854, -explorerHeight, 1848.8485);
    //    floorCorners[1] = new PVector ( -6125.0347, -explorerHeight, -405.64435);
    //    floorCorners[2] = new PVector ( -738.818, -explorerHeight, -4013.489);
    //    floorCorners[3] = new PVector ( -338.818, -explorerHeight, -3213.489);    
    //    floorCorners[4] = new PVector ( 2812.7913, -explorerHeight, -5016.7556);
    //    floorCorners[5] = new PVector ( 2894.0137, -explorerHeight, -1634.4142); 
    //    floorCorners[6] = new PVector (-5302.0854, -explorerHeight, 1848.8485);
    //    hasFloor = true;
    //    //function that compute where the collision shoud occur and the accuracy
    //    computeCollisionVector(15);

    //initialize the shape and set it to the position and scale    
    mapModel = loadShape("data/garage+primV2.obj");

    mapModel.scale(mapScale);
    mapModel.rotateX(radians(90));
    mapModel.rotateZ(radians(180));
    //set the current map name
    currentMap = mapName;

    myItems[1] = new Item ("casque", "garage", 1);
    println(this.mapName+" loaded");
  }




  //////////////////////////ARCADE/////////////////////////////
  void initArcade() {
    floorCorners = new PVector [5];
    //set up the floor as a collision object    
    floorCorners[0] = new PVector (-1873.6035, explorerHeight, -224.48772);
    floorCorners[1] = new PVector (87.57315, explorerHeight, 52.86044);
    floorCorners[2] = new PVector (500.89587, explorerHeight, 4525.886);
    floorCorners[3] = new PVector (-1816.1542, explorerHeight, 4149.824);    
    floorCorners[4] = new PVector (-1873.6035, explorerHeight, -224.48772);
    hasFloor = true;
    //function that compute where the collision shoud occur and the accuracy
    computeCollisionVector(15);

    //initialize the shape and set it to the position and scale
    //    explorerCam.jump(-1180, 200, 200);
    //    explorerCam.aim(-1180.8735, 200, 1000.0974);
    mapModel = loadShape("data/arcadeFinal.obj");
    mapModel.translate(0, 0, 0);
    mapModel.scale(mapScale);
    //    mapModel.rotateX(radians(90));
    mapModel.rotateZ(radians(180));
    //    mapModel.rotateY(radians(90));
    currentMap = mapName;
    println(this.mapName+" loaded");
  }


  //////////////////////////LIGHTS////////////////////////////////////////
  //handle the light for different maps
  void mapLights() {
    if (this.mapName == "arcade") {
      directionalLight(random(255)+90, random(255)+100, random(255)+100, 0, 1, 0);
      ambientLight(100, 100, 100, -893.9389, 200.0, 2306.427);
    }
    if (this.mapName == "garage") {
      //      ambientLight(100, 100, 100, -893.9389, 200.0, 2306.427);
      directionalLight(100, 100, 110, 0, -0.8, -2000);
    }
    if (this.mapName == "Chez Jeannot") {
      lights();
      ambientLight(175, 175, 175, -893.9389, 200.0, 2306.427);
      //      pointLight(100, 0, 110, 265, -1200, -1842);
      //      directionalLight(100, 100, 110, 0, -0.8, -2000);
    }
  }



  //////////////////////////////UTILITY////////////////////////////////////
  //create collision vectors if it has a floor
  void computeCollisionVector(int precision) {
    //checks if said map has a floor
    if (hasFloor) {
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

  void drawFloor() {
    if (debug) {
      fill(255, 0, 0);
      beginShape();
      for (int i = 0; i < floorCorners.length; i++) {
        vertex(floorCorners[i].x, -125, floorCorners[i].z);
      } 
      endShape(CLOSE);
      noFill();
    }
  }

  //a boolean funtion to check the collision
  boolean checkCollision () {
    //needs a floor to happen
    if (hasFloor) {
      //checks through all the collision vector
      for (int i = 0; i < collisionVectorIndex; i++) {
        //if one of these vector is too close to the camera  
        if (floorCollision[i].dist(PVcamPosition) < 250) {
          //print which one and return true          
          println("Dist"+i+" "+floorCollision[i].dist(PVcamPosition));
          return true;
        }
      }
    }
    //if none, just return false
    return false;
  }
  /////////////////////////////DISPLAY ITEMS  
  void items() {
    for (int i = 0; i < 1; i++) {
      myItems[i].show();
    }
  }
}

