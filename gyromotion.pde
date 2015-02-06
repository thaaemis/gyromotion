charge[] chargearray = new charge[0];
float t = 0;

void setup() {
  size(640,360,P3D);
  background(255);
  lights();
}

void draw() {
  
  lights();
  background(200);
  camera(800,900,700,320,180,0,0,1.0,0);
  if (mousePressed & chargearray.length < 10) {
    charge on = new charge(1,25,mouseX,mouseY,0,10,10,10);
    chargearray = (charge[])append(chargearray, on);
  }

  for (int i=0; i<chargearray.length; i++) {
    chargearray[i].display();
    chargearray[i].move();
    float[] whereis = chargearray[i].coords();
    if (whereis[0] > 1000) {
      chargearray[i].setxyz(-1000,whereis[1],whereis[2]);
    }
    if (whereis[1] > 1000) {
      chargearray[i].setxyz(whereis[0],-1000,whereis[2]);
    }
    if (whereis[2] > 1000) {
      chargearray[i].setxyz(whereis[0],whereis[1],-1000);
    }
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
  
  void setxyz(float ix,float iy, float iz) {
    x = ix;
    y = iy;
    z = iz;
  }
  
  float[] coords() {
    float[] whereis = { x, y, z };
    return whereis;
  }
  
  void display() {
    fill(200,100,0);
    translate(x,y,z);
    rotateY(atan(vx/vz));
    rotate(-atan(vy/vx));
    sphere(radius);
    line(0,0,0,0,0,radius*2);
  }
  
  void move() {
    x = x + vx;
    y = y + vy;
    z = z + vz;
  }
    
  
}
