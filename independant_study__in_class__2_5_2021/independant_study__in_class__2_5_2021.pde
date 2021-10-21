ArrayList<Vehicle> nodes = new ArrayList<Vehicle>();

public void setup() {
  size(1200, 800);
  createNodes();
}

public void draw() {
  background(51);
  update();
}


public void createNodes() {
  nodes.add(new Vehicle(random(width), random(height), 1.0, 1.0, 2.0));
  for (int i = 1; i < 2; i++) {
    nodes.add(new Vehicle(random(width), random(height), -3.0, 3.0, 4.0));
  }
}

public void update() {

  for (int i = 1; i < nodes.size(); i++) {
    //if(nodes.get(i).velocity.mag()<nodes.get(0).velocity.mag())
    //{
    //  nodes.get(i).velocity.mult(1.4*nodes.get(0).velocity.mag()/nodes.get(i).velocity.mag());
    // }
    if (i > 0) {
      nodes.get(i).findIntersect(nodes.get(0));
    }
    nodes.get(i).update();
    nodes.get(i).display();
  }
  nodes.get(0).update();
  nodes.get(0).display();
}
