charge[] chargearray = new charge[0];

void setup() {
  size(640,360,P3D);
  background(255);
  lights();
}

void draw() {
  
  lights();
  background(200);
  camera(800,900,700,320,180,0,0,1.0,0);
  if (mousePressed & chargearray.length < 4) {
    charge on = new charge(1,25,mouseX,mouseY,0,3,10,10);
    chargearray = (charge[])append(chargearray, on);
  }

  for (int i=0; i<chargearray.length; i++) {
    chargearray[i].display();
    chargearray[i].move();
  }
    
}

class charge {
  float q;
  float radius;
  float shade;
  float vx;
  float[][] vyz = new float[3][2];
  float[] x = new float[0];
  float[] y = new float[0];
  float[] z = new float[0];
  
  charge(float iq,float irad,float ix,float iy,float iz,
          float ivx, float ivy, float ivz) {
    q = iq;
    radius = irad;
    x = append(x,ix);
    y = append(y,iy);
    z = append(z,iz);
    vx = ivx;
    for (int i=0; i<3; i++) {
      vyz[i][0] = ivy;
      vyz[i][1] = ivz;
    }
  }
    
  void display() {
    fill(200,100,0);
    translate(x[0],y[0],z[0]);
    rotateY(atan(vx/vyz[0][1]));
    rotate(-atan(vyz[0][0]/vx));
    noStroke();
    sphere(radius);
    stroke(255,0,0);
    line(0,0,0,0,0,radius*5);
    noStroke();
    fill(0);
    if (x.length > 1) {
      for (int i=2; i<x.length; i=i+2) {
        translate(x[i]-x[i-2],y[i]-y[i-2],z[i]-z[i-2]);
        sphere(radius/10);
      }
    }
  }
  
  void move() {
    // Periodic boundary conditions
    if (x[0] > 1000.0 | x[0] < -1000.0) {
      x[0] = -x[0];
    }
    if (y[0] > 1000 | y[0] < -1000) {
      y[0] = -y[0];
    }
    if (z[0] > 1000 | z[0] < -1000) {
      z[0] = -z[0];
    }
    
    // Leapfrog method to update velocities in B-field
    vyz[2] = vyz[1];
    vyz[1] = vyz[0];
    for (int i=0; i<2; i++) {
      float newv = vyz[2][i] - 2*.1*q*vyz[1][i];
      vyz[0][i] = vyz[1][i] - .1/2*(vyz[1][i] + newv);
    }
    
    // manage arrays for trail of bubbles
    x = reverse(x);
    y = reverse(y);
    z = reverse(z);
    x = append(x,x[x.length-1] + vx);
    y = append(y,y[y.length-1] + vyz[0][0]);
    z = append(z,z[z.length-1] + vyz[0][1]);
    x = reverse(x);
    y = reverse(y);
    z = reverse(z);
    if (x.length > 10) {
      x = subset(x,0,10);
      y = subset(y,0,10);
      z = subset(z,0,10);
    }
  }
    
  
}
