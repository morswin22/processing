class Button {
  PVector pos;
  float w;
  float h;
  color scolor;
  color fcolor;
  String text;
  
  Button(float x, float y, float w_, float h_, String txt) {
    pos = new PVector(x,y);
    w = w_;
    h = h_;
    text = txt;
    scolor = color(0);
    fcolor = color(0);
  }
  
  Button(float x, float y, float w_, float h_, String txt, color scol, color fcol) {
    pos = new PVector(x,y);
    w = w_;
    h = h_;
    text = txt;
    scolor = scol;
    fcolor = fcol;
  }
  
  void show() {
    stroke(scolor);
    fill(fcolor);
    rect(pos.x,pos.y,w,h);
    
    noStroke();
    fill(0);
    textSize(16);
    textAlign(CENTER, CENTER);
    text(text, pos.x+(w/2), pos.y+(h/2));
  }
  
  boolean contains(float x, float y) {
    return (x < pos.x+w && y < pos.y+h && x > pos.x && y > pos.y);
  }

}
