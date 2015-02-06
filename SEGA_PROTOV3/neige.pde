////////////////////////////////////
Neige[] maNeige  = new Neige[5000];
PVector gravity = new PVector(0, 0.05, 0);
PVector vent = new PVector(random(-0.03, 0.03), 0, 0.06);
int noiseTime;

//keeping the snow function here for sake of cleaness
void showSnow() {
  strokeWeight(0.7);
  
  for (int i = 0; i < maNeige.length; i++) {
    stroke(maNeige[i].snowColor);

    maNeige[i].applyForce(vent);
    maNeige[i].applyForce(gravity);
    maNeige[i].updateLocation();
    maNeige[i].display();
  }
}


class Neige {
  PVector originalLocation;
  PVector location; 
  PVector velocity;
  PVector acceleration;

  float size;

  int snowColor;


  Neige (float x, float y, float z, PVector startingVelocity) {
    originalLocation = new PVector (x, -8000, z);
    location = new PVector (x, y, z);
    velocity = new PVector (0, 0, 0);
    acceleration = new PVector (0, 0, 0);
    velocity.set(startingVelocity);
    velocity.setMag(random(8,10));
    snowColor = round(random(160, 250));
  }

  Neige (float x, float y, float z) {
    originalLocation = new PVector (x, y, z);
    location = new PVector (x, y, z);
    velocity = new PVector (0, 0, 0);
    acceleration = new PVector (0, 0, 0);
  }

  void display() {   
    point(location.x, location.y, location.z);

    //    pushMatrix();
    //    translate(location.x, location.y, location.z);
    //    sphere(2);
    //    popMatrix();
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void updateLocation() {
    if (location.y > random(200, 300)) {
      location.set(originalLocation);
      //      velocity.mult(0);
      //      acceleration.mult(0);
    }


    //ajouter l,acceleration des force au mouvement actuel
    velocity.add(acceleration);
    //ajouter la velocité à la position actuelle
    location.add(velocity);
    velocity.limit(10);
    //reset a chaque fois pour pas que ca soit expodentiel.
    acceleration.mult(0);
  }
}

