class Obstacle {
  PVector pos;
  float w;
  float h;
  
  Obstacle (float x, float y, float w_, float h_) {
    pos = new PVector(x,y);
    w = w_;
    h = h_;
  }
  
  void show() {
    fill(255,0,255);
    rect(pos.x,pos.y,w,h);
  }
  
  boolean contains(PVector opos) {
    return (opos.x < pos.x+w && opos.y < pos.y+h && opos.x > pos.x && opos.y > pos.y);
  }
  
}
