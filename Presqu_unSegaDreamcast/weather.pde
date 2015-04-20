class Weather {
  //type of weather
  String type;

  //each weather system hold a Snow or a Fog System
  SnowSystem snow;
  FogSystem fog; 

  //Constructor
  //Needs a intial position, an areaSize, an total number of particule and the type of weather you want
  Weather(PVector position, int size, int totalParticule, String type) {
    this.type = type;
    //create a snow system if the type string is right
    if (type == "snow")
    //here creates a fog system
      snow = new SnowSystem (position, size, totalParticule);
    if (type == "fog")
      fog = new FogSystem (position, size);
      //this one create both using the same data
    if (type == "both") {
      fog = new FogSystem (position, size);
      snow = new SnowSystem (position, size, totalParticule);
    }
  }

  //display the system you created depending on the type string
  void display() {
    if (type == "snow")
      fog.display();
    if (type == "fog")
      fog.display();
    if (type == "both") {
      fog.display();
      snow.display();
    }
  }
}

