#Presqu'un Sega Dreamcast
Project Website : http://lerabot353.tumblr.com/

Presqu'un Sega Dreamcast is an exploration game made with processing.
Simply put, it loads OBJ as 3d Environnement and let you move around them using the WASD pattern.
It also feature a simply communication method to an arduino using the Serial library.
The arduino is used for a (not implemented yet) joystick controller and a (implemented and working) 20x4 HD44780 LCD screen.
The screen is used to display all the text (dialogue / though / observation) in the game.

###  Current Progress

v0.6 - Glitches are ok version

Just so you know, after some more thoughts given to the project, I'll stop focusing on stuff that are purely technical, like collision detection. I've given too much time on tech stuff and am now completly missing the point, which is the storytelling and whole experience. I'm now coding stuff that are relevent to the experience, and adding more text / maps.
* Add more to the GUI - like objective and position
* Add a fog system, and by that, will rework the weather system. This is needed for map 2, 3 and 4.
* Path following in map 3. Required.
* Might think about sound to give the whole thing a more cohesive experience.

V0.5 - Partially aborted - April 6th
* Focusing mainly on the floor detection / collision detection parts -'NOT ANYMORE'
* Needs a intro screen with level selection - 'DONE'
* Needs a loading screen


V0.4 - Done - March 16 2015
* Added 2 new maps
* Added snow for map 2
* Rewrited the LCDtext function to work with the all new GUI class
* Added a simple GUI
* Rewrited (partially) the walking
* Putted together a much needed player class with all the camera and moving methods
* Removed everything serial related for now
* Object class is on hold

V0.3 - Lightweight for Sophian
* Cleaned some unsued OBJ file
