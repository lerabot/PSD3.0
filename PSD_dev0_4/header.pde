////////////////////////////////////////////////
//ALL GLOBAL VARIABLE // IMPORTS ARE HERE
//////////////////////////////////////////////////

//TIME BASED STUFF///////////////////
int time;
int lastTime;

//SERIAL///////////////////
import processing.serial.*;
Serial serialPort;
String serialData;

//CAMERA///////////////////
import damkjer.ocd.*;
Camera explorerCam;

//is the game saving frames atm
boolean captureOn = false;

//PROGRESSION FLAG////////
boolean introDone = false;

//TEXT INFO//////////////////////////
PFont myFont;


//VISUAL STUFF///////////////////////////
PFont theFont;
PImage neigeImg;
PGraphics GUIrender;
PGraphics gameVisual;
PImage loading;


String currentMap;



