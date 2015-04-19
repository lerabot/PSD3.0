////////////////////////////////////////////////
//ALL GLOBAL VARIABLE // IMPORTS ARE HERE
//////////////////////////////////////////////////

//TIME BASED STUFF///////////////////
//keeps track of the time
int time;


//SERIAL///////////////////
//imports the Serail library and keeps the instance of the serial data
import processing.serial.*;
Serial serialPort;

//CAMERA///////////////////
//special library to facilitate the use of camera in processing
import damkjer.ocd.*;
Camera explorerCam;

//set the frame capture mode on or off
boolean captureOn = false;

//TEXT INFO//////////////////////////
PFont myFont;


//VISUAL STUFF///////////////////////////
static final int GAME_WIDTH = 1280;
static final int GAME_HEIGHT = 720;

//Map stuff//////
//return a String ta hold the current map the player is in
String currentMap;
//holds the map names
String[] mapList = new String[5];

//keeps track of if a key has been pressed but not released
boolean keyReady;

//an instance of the gameController object, which handle the custom made 
GameController manette;

//simple flag to get faster loading if I don't need all the models
boolean debug = false;
