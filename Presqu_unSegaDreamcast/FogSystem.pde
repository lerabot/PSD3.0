

class FogSystem {

  ArrayList<Particules> fogElements;

  int totalParticules;

  PImage fogImg;

  PVector position;


  int areaSize;
  PVector fogWind = new PVector (2, 0, 1);


  FogSystem (PVector position, int size) {
    totalParticules = 25;
    this.position = new PVector (0, 0, 0);
    this.position.set(position);
    areaSize = size;


    fogImg = loadImage("fog2.png");


    fogElements = new ArrayList<Particules>();
    for (int i = 0; i < totalParticules; i++) {
      //ajoute de la neige à la location. la location est le centre de la tempete.
      //fogElements.add(new Particules(position.x, random(-200, 300), position.z, fogWind));
      fogElements.add(new Particules(random(position.x-areaSize, position.x+areaSize), random(-200, 300), random(position.z-areaSize, position.z+areaSize), fogWind));
    }
  }

  void display() {

    if (totalParticules != 0) {
      for (int i = fogElements.size ()-1; i >= 0; i--) {
        Particules p = fogElements.get(i);
        p.updateLocation();
        pushMatrix();
        translate(p.getPosition().x, p.getPosition().y, p.getPosition().z);
        scale(p.getScale()*20);
        rotateY(p.getAngle());

        image(fogImg, 0, 0);

        popMatrix();
        //        if (p.location.dist(thePlayer.getPosition()) > 2000 ) {
        //          position.set(thePlayer.getPosition());
        //          fogElements.remove(i);
        //          fogElements.add(new Particules(random(position.x-areaSize, position.x+areaSize), random(-200, 300), random(position.z-areaSize, position.z+areaSize), fogWind));;
        //        }
      }
    }
  }
}

