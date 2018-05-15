class Goal {
  PVector pos;
  int r;
  
  Goal(float x, float y, int r_) {
    pos = new PVector(x,y);
    r = r_;
  }
  
  void show() {
    fill(255,0,0);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}
