//a model class for particules mostly used in the weather system

class Particules {
  PVector originalLocation;
  PVector location; 
  PVector velocity;
  PVector acceleration;
  float angle;
  float noiseTime;
  float scale;

  Particules (float x, float y, float z, PVector startingVelocity) {
    originalLocation = new PVector (x, -8000, z);
    location = new PVector (x, y, z);
    velocity = new PVector (0, 0, 0);
    acceleration = new PVector (0, 0, 0);
    velocity.set(startingVelocity);
    velocity.setMag(random(0, 5));
    angle = radians(random(-90, 90));
    scale = random(1, 4);
  }

  Particules (float x, float y, float z) {
    originalLocation = new PVector (x, y, z);
    location = new PVector (x, y, z);
    velocity = new PVector (0, 0, 0);
    acceleration = new PVector (0, 0, 0);
    angle = radians(random(-90, 90));
    scale = random(1, 4);
  }

  PVector getPosition() {  
    return location;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  float getScale() {
    return scale;
  }

  float getAngle() {
    return angle;
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

