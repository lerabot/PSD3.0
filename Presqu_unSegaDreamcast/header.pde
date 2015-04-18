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

boolean keyReady;

GameController manette;

//simple flag to get faster loading if I don't need all the models
boolean debug = false;
