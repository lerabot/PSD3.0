

class FogSystem {
  //holds the particules used in the fog system
  ArrayList<Particules> fogElements;
  //keeps track of the max number of particules possible
  int totalParticules;
  //a visual representation of the fog
  PImage fogImg;
  //position to draw the system
  PVector position;
  //sets the size of the area to be corvered by the fog system
  int areaSize;
  //a simple force to have a moving fog.
  PVector fogWind = new PVector (2, 0, 1);
  //a scale value for the fog image
  final int FOG_SCALE = 20;

  FogSystem (PVector position, int size) {

    totalParticules = 25;
    //position to draw the system
    this.position = new PVector (0, 0, 0);
    this.position.set(position);
    //sets the size of the area to be corvered by the fog system
    areaSize = size;
    //load the said image for the fog
    fogImg = loadImage("fog2.png");
    //creates an ArrayList contaning the particules used in the system
    fogElements = new ArrayList<Particules>();
    //populates them using the maxium number of particule
    for (int i = 0; i < totalParticules; i++) {
      //adds fog element, they are randomly positioned where the PVector position is, in the area designed
      fogElements.add(new Particules(random(position.x-areaSize, position.x+areaSize), random(-200, 300), random(position.z-areaSize, position.z+areaSize), fogWind));
    }
  }

  //draws the fogs
  void display() {
    //only displays if there's more than 0 particule
    if (totalParticules != 0) {
      //iterates though the array list and draws Fog elements at the particule position
      for (int i = fogElements.size ()-1; i >= 0; i--) {
        Particules p = fogElements.get(i);
        //gets the location of the particules
        p.updateLocation();
        pushMatrix();
        //moves the origin at the calculated particule position
        translate(p.getPosition().x, p.getPosition().y, p.getPosition().z);
        //scales the fog image by the fog scale factor
        scale(p.getScale()*FOG_SCALE);
        //also rotates the drawing so not every fog element is aligned
        rotateY(p.getAngle());
        //actually draws the image
        image(fogImg, 0, 0);
        popMatrix();
      }
    }
  }
}

