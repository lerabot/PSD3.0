class Weather {

  String type;

  SnowSystem snow;
  FogSystem fog; 

  Weather(PVector position, int size, int totalParticule, String type) {
    this.type = type;
    if (type == "snow")
      snow = new SnowSystem (position, size, totalParticule);
    if (type == "fog")
      fog = new FogSystem (position, size);
    if (type == "both") {
      fog = new FogSystem (position, size);
      snow = new SnowSystem (position, size, totalParticule);
    }
  }

  void display() {

    if (type == "snow")
      snow.display();
    if (type == "fog")
      fog.display();
    if (type == "both") {
      fog.display();
      snow.display();
    }
  }
}

