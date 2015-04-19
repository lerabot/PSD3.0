////////////////////////////////////



class SnowSystem {
  //nombre de flocons
  int totalNeige;
  //origin de la tempete
  PVector location;
  //grosseur de cette tempete
  int tempeteSize; 
  //contains all the snow particules
  ArrayList<Particules> laNeige;
  //the visual represenation of the particules
  PImage neigeImg;
  //scale factor of the snow image
  final int SNOW_SCALE = 2;
  ///forces affective these particules
  PVector gravity = new PVector(0, 0.1, 0);
  PVector vent = new PVector(0, 0, 0.6);

  //CONSTRUCTOR
  ///takes a starting point for the snowstorm, a size for the area to cover, and the totals nowflakes
  SnowSystem (PVector startPoint, int tempeteSize, int totalNeige) {
    //maximum amount of snowskates
    this.totalNeige = totalNeige;
    //initialize a new location PVector
    location = new PVector (0, 0, 0);
    //sets it to the given startign point PVector
    location.set(startPoint);
    //save the size of the snowstorm area
    this.tempeteSize = tempeteSize;
    //the visual representation of the snowflake  
    neigeImg = loadImage("neige.png");
    //create a new Arraylist containing all the snow particules
    laNeige = new ArrayList<Particules>();
    //populates it using the totalNeige snowsflake variavle
    for (int i = 0; i < totalNeige; i++) {
      //ajoute de la neige à la location. la location est le centre de la tempete.
      laNeige.add(new Particules(random(location.x-tempeteSize/2, location.x+tempeteSize/2), random(-15000), random(location.z-tempeteSize/2, location.z+tempeteSize/2)));
    }
  }

  //main drawing fuction
  void display() {
    // if there's more than 0 snowflakes
    if (totalNeige != 0) {
      //goes throught all the snow particule
      for (int i = laNeige.size ()-1; i >= 0; i--) {
        //changes the wind slightly for each aprticule
        vent.set(random(-0.1, 0.2), 0, random(-0.2, 0.1));
        //gets an instance of a particule object
        Particules n = laNeige.get(i);
        //applys all the forces here
        n.applyForce(vent);
        n.applyForce(gravity);
        //updates the location of the particules
        n.updateLocation();
        pushMatrix();
        //translate the origin to the particule postion
        translate(n.getPosition().x, n.getPosition().y, n.getPosition().z);
        //scales and rotate the image according to the particule angle and scale factor        
        scale(n.getScale()*SNOW_SCALE);
        //currently disable, cause this makes the sketch MUCH slower
        //rotateY(n.getAngle());
        //draws the snowflake image 
        image(neigeImg, 0, 0);
        popMatrix();
        //if the snowflakes is outside a said range, it delete the currentl snowflakes and adds a new one
        if (n.location.y > random(400, 800)) {
          //uses the current player plosition to generate a new slofakes, this allows for a more centralized effect 
          location.set(thePlayer.playerPosition);
          //removes the current particule
          laNeige.remove(i);
          //adds a new particule
          laNeige.add(new Particules(random(location.x-tempeteSize/2, location.x+tempeteSize/2), -5000, random(location.z-tempeteSize/2, location.z+tempeteSize/2)));
          //      velocity.mult(0);
          //      acceleration.mult(0);
        }
      }
    }
  }
}

