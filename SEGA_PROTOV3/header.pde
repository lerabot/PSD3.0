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

//the camera position and it's target, and a PVector copy of it for PVector Maths
PVector PVcamTarget;
PVector PVcamPosition;
float[] camPosition;
float[] camTarget;

//2 variable used for mouse debuggin
float tumbleX;
float tumbleY;

//offset from the camera, to measure the player's height
int explorerHeight = 850;

//lenght of footsteps
float footstep = 0;
//lenght of the walking animation
int stepTime = 25;
//counter for the animation lenght
int stepDone = 0;
//the angle value for the walking feel
//Two_pi is half a circle divided by the incrementation maximum
float walkingBumpAngle = TWO_PI/stepTime;
//increment each time we walk but keeps the angle
float walkingBumpIncr = 0;

//same as up here but for rotation movement
float rotationAngle = 0;
int rotationTime = 10;
int rotationDone = 0;

//MAPS///////////////////
Map myIntro;
Map myGarage;
Map myArcade;
Map myPapi;
Map myPapiGarage;
Map myPapiExt;

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

