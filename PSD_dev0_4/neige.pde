////////////////////////////////////

PVector gravity = new PVector(0, 0.1, 0);
PVector vent = new PVector(0, 0, 0.6);
PVector vent2 = new PVector(0, 0, 0);

class TempeteNeige {
  //nombre de flocons
  int totalNeige;
  //origin de la tempete
  PVector location;
  //grosseur de cette tempete
  int tempeteSize; 
  ArrayList<Neige> laNeige;

  TempeteNeige (int totalNeige, PVector startPoint, int tempeteSize) {
    this.totalNeige = totalNeige;
    location = new PVector (0, 0, 0);
    location.set(startPoint);
    this.tempeteSize = tempeteSize;

    laNeige = new ArrayList<Neige>();
    for (int i = 0; i < totalNeige; i++) {
      //ajoute de la neige à la location. la location est le centre de la tempete.
      laNeige.add(new Neige(random(location.x-tempeteSize/2, location.x+tempeteSize/2), random(-10000)*2, random(location.z-tempeteSize/2, location.z+tempeteSize/2)));
    }
  }

  void showTempete() {
    if (totalNeige != 0) {
      for (int i = laNeige.size ()-1; i >= 0; i--) {
        vent.set(random(-0.1, 0.3), random(0.2), 0);
        vent2.set(vent);
        vent2.mult(5);
        Neige n = laNeige.get(i);
        if (i % 5 == 0) 
          n. applyForce(vent2);
        n.applyForce(vent);
        n.applyForce(gravity);
        n.updateLocation();
        n.display();
        if (n.location.y > random(600)) {
          location.set(thePlayer.playerPosition);
          laNeige.remove(i);
          laNeige.add(new Neige(random(location.x-tempeteSize/2, location.x+tempeteSize/2), -5000, random(location.z-tempeteSize/2, location.z+tempeteSize/2)));
          //      velocity.mult(0);
          //      acceleration.mult(0);
        }
      }
    }
  }
}


class Neige {
  PVector originalLocation;
  PVector location; 
  PVector velocity;
  PVector acceleration;
  int initialAngle;
  int noiseTime;

  Neige (float x, float y, float z, PVector startingVelocity) {
    originalLocation = new PVector (x, -8000, z);
    location = new PVector (x, y, z);
    velocity = new PVector (0, 0, 0);
    acceleration = new PVector (0, 0, 0);
    velocity.set(startingVelocity);
    velocity.setMag(random(0, 5));
    initialAngle = int(random(360));
  }

  Neige (float x, float y, float z) {
    originalLocation = new PVector (x, y, z);
    location = new PVector (x, y, z);
    velocity = new PVector (0, 0, 0);
    acceleration = new PVector (0, 0, 0);
  }

  void display() {  
    //    point(location.x, location.y, location.z);

    pushMatrix();
    translate(location.x, location.y, location.z);
    rotateY(radians(initialAngle*(noise(noiseTime, 50))));
    image(neigeImg, 0, 0, 10, 10);   
    popMatrix();
    noiseTime++;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void updateLocation() {
    //ajouter l'acceleration des force au mouvement actuel
    velocity.add(acceleration);
    //ajouter la velocité à la position actuelle
    location.add(velocity);
    velocity.limit(10);
    //reset a chaque fois pour pas que ca soit expodentiel.
    acceleration.mult(0);
  }
}

