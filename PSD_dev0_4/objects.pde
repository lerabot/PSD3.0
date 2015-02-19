///////////////////////////////////////
//Items
/////////////////////////////////

class Item {
  //attributes
  //save the item psotion
  PVector itemPosition;
  //trajectory PVector calculated from the relation between camera placement and target
  PVector calculatedItemPosition;
  //a PVector to increase the itemPosition by
  PVector moveItem;

  // keeps the item name
  String itemName;

  //witch map is the item in
  String inMap;
  //do you have it in your inventory
  boolean inInventory;
  //have you used the item yet
  boolean used;

  int itemIndexNum;

  //defines the 3d model of the shape
  PShape itemModel;

  //method
  //constructor initiate the object at said posision and initialize the other required PVectors too
  public Item (String itemName, String inMap, int itemIndexNum) {
    this.itemName = itemName;   
    this.inMap = inMap;
    this.itemIndexNum = itemIndexNum;
    this.itemPosition = new PVector (0, 0, 0);
    this.calculatedItemPosition = new PVector (0, 0, 0);
    this.moveItem = new PVector (0, 0, 0);
    //call each item init
    if (itemName == "casque") initCasque();
  }



  //shows the model
  void show() {
    //check if the model is in inventory
    if (inInventory) {
      //check what item you,re currently viewing
      if (itemIndexNum == itemIndex) {
        //displays the model in fron of you and spins it
        updatePosition();
      }
      // if it's not in your inventory, is it on the current map?
    } else {
      if (currentMap == inMap) {
        //check if the item is near enough to get it
        getItem();
        //refresh the item every frame
        pushMatrix();
        translate(itemPosition.x, itemPosition.y, itemPosition.z);
        shape(itemModel);
        popMatrix();
      }
    }
  }

  //quick class to check if the player is close enough to grab the item
  void getItem() {
    //distance checker
    if (itemPosition.dist(thePlayer.getPosition()) < 600) {
      //changes the flag to true if the item is clsoe enough
      inInventory = true;
      //makes it a big bigger in inventory
      itemModel.scale(1);
      serialPort.write(itemName+"\n");
      //debug purpose
      println(itemName+ " aquired");
    }
  }

  //updates the position and the rotation of the obect
  void updatePosition() {
    //using linear interpolation, give a precice coordinate of what's in front of us
    calculatedItemPosition = PVector.lerp(thePlayer.getTarget(), thePlayer.getPosition(), 0.4);
    pushMatrix();
    //moves coordinate system to this particular spot
    translate(calculatedItemPosition.x, calculatedItemPosition.y-250, calculatedItemPosition.z);
    //rotate the model
    itemModel.rotateY(-0.03);
    //shows the model
    shape(itemModel);
    //return to riginal coord system
    popMatrix();
  }

  //initialize the helmet
  void initCasque() {    
    println(currentMap == inMap);   
    inInventory = false;
    itemPosition.set(-3498.6326, 1200, -1773.5488);
    itemModel = loadShape ("data/masque2.obj");
    itemModel.scale(0.6);
    itemModel.rotateZ(radians(180));
  }
}

