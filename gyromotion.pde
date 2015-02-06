charge[] chargearray = new charge[0];
float t = 0;

void setup() {
  size(640,360,P3D);
  background(255);
  lights();
//  charge ch = new charge(1,3,0,0,0,10,10,10);
//  chargearray[0] = ch;
}

void draw() {
  
  lights();
  background(200);
  camera(500*sin(t),500*cos(t),700,320,180,0,0,1.0,0);
  if (mousePressed & chargearray.length < 10) {
    charge on = new charge(1,25,mouseX,mouseY,0,10,10,10);
    chargearray = (charge[])append(chargearray, on);
  }
  
//  charge ch = new charge(1,100,0,0,0,10,10,10);
//  ch.display();

  for (int i=0; i<chargearray.length; i++) {
    chargearray[i].display();
  }
  
  t = t + PI/300;
    
}

class charge {
  float q;
  float radius;
  float shade;
  float vx;
  float vy;
  float vz;
  float x;
  float y;
  float z;
  
  charge(float iq,float irad,float ix,float iy,float iz,
          float ivx, float ivy, float ivz) {
    q = iq;
    radius = irad;
    x = ix;
    y = iy;
    z = iz;
    vx = ivx;
    vy = ivy;
    vz = ivz;
  }
  
  void display() {
    fill(200,100,0);
    translate(x,y,z);
//    rotateY(atan(vx/vz));
//    rotate(-atan(vy/vx));
    sphere(radius);
    line(0,0,0,0,0,radius*2);
  }
  
  
  
}
