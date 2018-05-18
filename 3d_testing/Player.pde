class Player {
  float rotationAngle;
  float elevationAngle;
  
  float centerX;
  float centerY;
  float centerZ;
  
  PVector pos;
  PVector vel;
  PVector acc;
  
  float speed;
  float maxspeed;
  
  float w;
  float h;
  
  boolean[] keys;
  
  boolean canJump = false;
  PVector jumpForce = new PVector(0,0,0);
  
  Player() {
    pos = new PVector(GRID_WIDTH*(GRID_SIZE/2),-GRID_WIDTH*(GRID_SIZE/2),0);
    vel = new PVector(0,0,0);
    acc = new PVector(0,0,0);
    keys = new boolean[5];
    keys[0] = false; //w
    keys[1] = false; //a
    keys[2] = false; //s
    keys[3] = false; //d
    keys[4] = false; //d
    
    speed = 2;
    maxspeed = 14;
    
    w = 60;
    h = 172;
  }
  
  boolean intersect(Box a) {
    return (a.pos.x <= pos.x+w && a.pos.x+a.w >= pos.x) &&
         (a.pos.y <= pos.y+w && a.pos.y+a.w >= pos.y) &&
         (a.pos.z <= pos.z+h && a.pos.z+a.w >= pos.z);
  }
  
  void move() {
    float fx = speed * cos(rotationAngle); 
    float fy = speed * sin(rotationAngle); 
    float sx = speed * cos(rotationAngle+PI/2); 
    float sy = speed * sin(rotationAngle+PI/2); 
    //float z = speed * -cos(rotationAngle);
    if (keys[0]) {acc.add(new PVector(fx,fy,0));}
    if (keys[2]) {acc.sub(new PVector(fx,fy,0));}
    if (keys[1]) {acc.add(new PVector(sx,sy,0));}
    if (keys[3]) {acc.sub(new PVector(sx,sy,0));}
    
    acc.z+=speed;
    if (vel.z >= 0 && canJump && keys[4]) {
      jumpForce.z = -maxspeed;
      canJump = false;
    }
    
    jumpForce.mult(0.86);
    
  }
  
  void update() {
    acc.add(jumpForce);
    
    vel.add(acc);
    vel.limit(maxspeed);
    vel.mult(0.88);
    
    pos.x += vel.x;
    for (Box b : blocks) {
      if (intersect(b)) {
        pos.x -= vel.x;
        vel.x = 0;
      }
    }
    pos.y += vel.y;
    for (Box b : blocks) {
      if (intersect(b)) {
        pos.y -= vel.y;
        vel.y = 0;
      }
    }
    pos.z += vel.z;
    for (Box b : blocks) {
      if (intersect(b)) { 
        if (vel.z > 0) {// floor!
          canJump = true;
        } 
        pos.z -= vel.z;
        vel.z = 0;
      }
    }
    
    acc.mult(0);
  }
  
  void updateCamera() {
    rotationAngle = rotationAngle - map(mouseX, 0, width, -PI, PI);
    elevationAngle = elevationAngle + map(mouseY, 0, height, -PI, PI);
    
    elevationAngle = constrain(elevationAngle, 0.2, PI-0.2);
  
    centerX = cos(rotationAngle) * sin(elevationAngle);
    centerY = sin(rotationAngle) * sin(elevationAngle);
    centerZ = -cos(elevationAngle);
  
    camera(pos.x+w/2, pos.y+w/2, pos.z-h/3, pos.x+w/2 + centerX, pos.y+w/2 + centerY, pos.z-h/3 + centerZ, 0, 0, 1);
    
  }
  
  void kPress(int kcode) {
    switch(kcode) {
      case 87: // w
        keys[0] = true;
        break;
      case 65: // a
        keys[1] = true;
        break;
      case 83: // s
        keys[2] = true;
        break;
      case 68: // d
        keys[3] = true;
        break;
      case 32: // space
        keys[4] = true;
        break;
      default:
        println(kcode);
        break;
    }
  }
  
  void kRelease(int kcode) {
    switch(kcode) {
      case 87: // w
        keys[0] = false;
        break;
      case 65: // a
        keys[1] = false;
        break;
      case 83: // s
        keys[2] = false;
        break;
      case 68: // d
        keys[3] = false;
        break;
      case 32: // space
        keys[4] = false;
        break;
      default:
        println(kcode);
        break;
    }
  }

}
