//a model class for particules mostly used in the weather system
class Particules {
  //the original location of the particule when is was initiated
  PVector originalLocation;
  //it's current location
  PVector location; 
  //it's velocity
  PVector velocity;
  //current acceleration
  PVector acceleration;
  //the angle at which it is drawn
  float angle;
  //noice time index
  float noiseTime;
  //scale at which it is drawn
  float scale;

  Particules (float x, float y, float z, PVector startingVelocity) {
    //the original location of the particule when is was initiated
    originalLocation = new PVector (x, y, z);
    //sets the location of said particule
    location = new PVector (x, y, z);
    //iniatlize a PVector for the velocity
    velocity = new PVector (0, 0, 0);
    //initialize a PVector for the acceleration
    acceleration = new PVector (0, 0, 0);
    //sets the starting velocity with the given pvector
    velocity.set(startingVelocity);
    //give a sligthly diffent magnitude to all the particule
    velocity.setMag(random(0, 5));
    //since those are mostly drawn on screen, this ensure that the particule are not all drawn in the same angle
    angle = radians(random(-90, 90));
    //also gives random scales to particules
    scale = random(1, 4);
  }

  //same thing without the initial starting velocity
  Particules (float x, float y, float z) {
    originalLocation = new PVector (x, y, z);
    location = new PVector (x, y, z);
    velocity = new PVector (0, 0, 0);
    acceleration = new PVector (0, 0, 0);
    angle = radians(random(-90, 90));
    scale = random(1, 4);
  }

  //return the position of the particule
  PVector getPosition() {  
    return location;
  }

  //apply a force to the particule
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  //returns the actual scale of said particule
  float getScale() {
    return scale;
  }

  //return the angle of said particule
  float getAngle() {
    return angle;
  }

  //updates the location of said particule
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

