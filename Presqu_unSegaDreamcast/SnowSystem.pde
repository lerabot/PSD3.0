////////////////////////////////////



class SnowSystem {
  //nombre de flocons
  int totalNeige;
  //origin de la tempete
  PVector location;
  //grosseur de cette tempete
  int tempeteSize; 
  ArrayList<Particules> laNeige;

  PImage neigeImg;

  PVector gravity = new PVector(0, 0.1, 0);
  PVector vent = new PVector(0, 0, 0.6);


  SnowSystem (PVector startPoint, int tempeteSize, int totalNeige) {
    this.totalNeige = totalNeige;
    location = new PVector (0, 0, 0);
    location.set(startPoint);
    this.tempeteSize = tempeteSize;

    neigeImg = loadImage("neige.png");


    laNeige = new ArrayList<Particules>();
    for (int i = 0; i < totalNeige; i++) {
      //ajoute de la neige à la location. la location est le centre de la tempete.
      laNeige.add(new Particules(random(location.x-tempeteSize/2, location.x+tempeteSize/2), random(-10000)*2, random(location.z-tempeteSize/2, location.z+tempeteSize/2)));
    }
  }

  void display() {
    if (totalNeige != 0) {
      for (int i = laNeige.size ()-1; i >= 0; i--) {
        vent.set(random(-0.1, 0.2), 0, random(-0.2, 0.1));
        Particules n = laNeige.get(i);
        n.applyForce(vent);
        n.applyForce(gravity);
        n.updateLocation();
        pushMatrix();
        translate(n.getPosition().x, n.getPosition().y, n.getPosition().z);
        scale(n.getScale()*2);
        //rotateY(n.getAngle());
        image(neigeImg, 0, 0);
        popMatrix();
        if (n.location.y > random(400, 800)) {
          location.set(thePlayer.playerPosition);
          laNeige.remove(i);
          laNeige.add(new Particules(random(location.x-tempeteSize/2, location.x+tempeteSize/2), -5000, random(location.z-tempeteSize/2, location.z+tempeteSize/2)));
          //      velocity.mult(0);
          //      acceleration.mult(0);
        }
      }
    }
  }
}

