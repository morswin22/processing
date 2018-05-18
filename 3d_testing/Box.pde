class Box {
  PVector pos;
  float w;
  color cfill;
  
  boolean selected = false;
  
  Box(float x, float y, float z) {
    pos = new PVector(x,y,z);
    w = GRID_WIDTH;
    cfill = color(255);
  }
  
  Box(float x, float y, float z, color c) {
    pos = new PVector(x,y,z);
    w = GRID_WIDTH;
    cfill = c;
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    if (!selected) {
      fill(cfill);
    } else {
      fill(255,0,0);
    }
    stroke(0);
    box(w);
    popMatrix();
  }
  
  void select() {
    selected = true;
  }
  
  boolean isHover() {
    float minX = screenX(pos.x, pos.y, pos.z);
    float minY = screenY(pos.x, pos.y, pos.z);
    float maxX = screenX(pos.x+w, pos.y+w, pos.z+w);
    float maxY = screenY(pos.x+w, pos.y+w, pos.z+w); 
    
    return ((mouseX <= maxX && mouseX >= minX) &&
         (mouseY <= maxY && mouseY >= minY));
  }

}
