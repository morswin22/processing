import java.awt.*;

float GRID_WIDTH  = 100;
float GRID_SIZE   = 50;
float GRID_HEIGHT = 1;
Box[] blocks;

//float rotateX = 0; // UP   / DOWN
//float rotateY = 0; // LEFT / RIGHT
//float rotateZ = 0; // ROLL

Player player;

void setup() {
  fullScreen(P3D);
  noCursor();
  
  float step = 0.038;
  float xoff = 0;
  
  blocks = new Box[8 + (int)(GRID_SIZE*GRID_HEIGHT*GRID_SIZE)];
  int i = 0;
  for (int x = 0 ; x < GRID_SIZE; x++) {
    float yoff = 0;
    for (int y = 0 ; y < GRID_HEIGHT; y++) {
      float zoff = 0;
      for (int z = 0 ; z < GRID_SIZE; z++) {
        blocks[i] = new Box(x*GRID_WIDTH,-z*GRID_WIDTH,y*GRID_WIDTH + (10*GRID_WIDTH) + (int)map(noise(xoff,yoff,zoff), 0, 1, 0, 10)*GRID_WIDTH);
        i++;
        zoff += step;
      }
      yoff += step;
    }
    xoff += step;
  }
  
  blocks[i+0] = new Box((GRID_SIZE-1)*GRID_WIDTH,-(GRID_SIZE-1)*GRID_WIDTH,9*GRID_WIDTH);
  blocks[i+1] = new Box((GRID_SIZE-1)*GRID_WIDTH,-(GRID_SIZE-1)*GRID_WIDTH,0, color(255,0,0));
  
  blocks[i+2] = new Box((GRID_SIZE-1)*GRID_WIDTH,0,9*GRID_WIDTH);
  blocks[i+3] = new Box((GRID_SIZE-1)*GRID_WIDTH,0,0, color(255,0,0));
  
  blocks[i+4] = new Box(0,-(GRID_SIZE-1)*GRID_WIDTH,9*GRID_WIDTH);
  blocks[i+5] = new Box(0,-(GRID_SIZE-1)*GRID_WIDTH,0, color(255,0,0));
  
  blocks[i+6] = new Box(0,0,9*GRID_WIDTH);
  blocks[i+7] = new Box(0,0,0, color(255,0,0));
   
  player = new Player();
}

void draw() {
  background(51);
  
  player.updateCamera();
  try {
    Robot robot = new Robot();
    robot.mouseMove( width/2, height/2 );  
  } catch (AWTException e) {}
  player.move();
  player.update();
  
  for (Box b : blocks) {
    b.render();
    b.selected = false;
  }
  
  for (Box b : blocks) {
    if(b.isHover()) {
      b.select();
      break;
    }
  }

}

void keyPressed() {
  player.kPress(keyCode);
}

void keyReleased() {
  player.kRelease(keyCode);
}
