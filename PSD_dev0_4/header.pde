////////////////////////////////////////////////
//ALL GLOBAL VARIABLE // IMPORTS ARE HERE
//////////////////////////////////////////////////

//SERIAL///////////////////
import processing.serial.*;
Serial serialPort;
String serialData;

//CAMERA///////////////////
import damkjer.ocd.*;
Camera explorerCam;
boolean collisionAlert = false;
//is the game saving frames atm
boolean captureOn = false;



Player thePlayer;





String currentMap;
//ITEM/////////////////////
int itemIndex = 0;
Item myItems[] = new Item [10];

//PROGRESSION FLAG////////
boolean introDone = false;

//TEXT INFO//////////////////////////
PFont myFont;
String lines[];
int currentText = 0;



////////////////////////////////////////
PImage neigeImg;
