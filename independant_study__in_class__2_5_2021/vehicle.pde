class Vehicle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  int m;
  PVector intersect;

  Vehicle(float x, float y, float vx, float vy, float locMS) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(vx, vy);
    location = new PVector(x, y);
    r = 6;
    maxspeed = locMS;
    maxforce = 10;
  }


  public void findIntersect(Vehicle v) {
    if (true) {//if (velocity.mag() > v.velocity.mag()) {
      float d, e, f;
      float t;
      PVector a = v.velocity;
      PVector c = new PVector(this.location.x-v.location.x, this.location.y-v.location.y);
      float beta = PVector.angleBetween(a, c);
      d = abs((this.velocity.magSq() - v.velocity.magSq()));
      if (d==0)
      {
        d = 1;
      }
      e = 2*v.velocity.mag()*cos(beta);
      f = -pow(c.mag(), 2.0);
      t = (-e+sqrt(pow(e, 2.0)-4.0*d*f))/(2.0*d);
      print(t+" ");
      intersect = new PVector(0, 0);
      intersect.add(v.location);
      PVector tempPV = v.velocity;
      intersect.add(tempPV.mult(t));
      stroke(255);
      line(location.x, location.y, intersect.x, intersect.y);
      line(v.location.x, v.location.y, intersect.x, intersect.y);
      seek(intersect);
    } //else {
    //   seek(v.location);
    // }
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target

    // Scale to maximum speed
    desired.setMag(maxspeed);

    // Steering = Desired minus velocity
    PVector steer = desired;//PVector.sub(desired, velocity);
    //steer.limit(maxforce);  // Limit to maximum steering force

    applyForce(steer);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  void display() {
    if (intersect != null) {
      ellipse(intersect.x,intersect.y,10,10);
    }
    color red = color(255, 0, 0);
    color green = color(0, 255, 0);
    float lerpAmmount = map(m, 0, height, 0, 1);
    color massColor = lerpColor(green, red, lerpAmmount);
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + PI/2;
    push();
    translate(location.x, location.y);
    stroke(0, 0, 255);
    line(0, 0, velocity.x*20, velocity.y*20);
    pop();
    fill(255, 0, 0);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
  void update() {
    if (onIntersectionPoint()) {
      location = new PVector(random(width), random(height));
    }
    PVector a = location;
    if (a.x < 1) {
      a.x = width;
    } else if (a.x > width-1) {
      a.x = 1;
    }
    if (a.y < 1) {
      a.y = height-1;
    } else if (a.y > height-1) {
      a.y = 1;
    }
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    //velocity.setMag(5);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

  public boolean onIntersectionPoint() {
    boolean onPoint = false;
    if (intersect != null) {
      if (location.x > intersect.x-2 && location.x < intersect.x+2 && location.y > intersect.y-2 && location.y < intersect.y+2) {
        onPoint = true;
      }
    }

    return onPoint;
  }
}
