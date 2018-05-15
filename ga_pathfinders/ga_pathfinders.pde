Population population;
Goal goal;
Obstacle[] obstacles;

Button restartBtn;
Button bestBtn;
Button speedBtn;

int epochs = 1;

void setup () {
  size(800, 800);
  goal = new Goal(400, 50, 5);
  
  obstacles = new Obstacle[2];
  obstacles[0] = new Obstacle(0, 300, 500, 10);
  obstacles[1] = new Obstacle(300, 550, 500, 10);
  
  population = new Population(1000, goal, obstacles);
  
  restartBtn = new Button(10.0,10.0,110.0,25.0, "Randomize", color(0), color(255,0,0));
  bestBtn = new Button(10.0,45.0,45.0,25.0, "Best", color(0), color(0,255,255));
  speedBtn = new Button(65.0,45.0,55.0,25.0, "Speed", color(0), color(0,255,255));
}

void draw() {
  background(255);
  
  for (int i = 0; i < epochs; i++) {
    if (population.allDotsDead()) {
      // ga
      population.calculateFitness();
      population.naturalSelection();
      population.mutate();
    } else {
      // simulation
      population.update();
      population.show();
    }
  }
  
  restartBtn.show();
  bestBtn.show();
  speedBtn.show();
  textAlign(LEFT,TOP);
  text("Epochs: " + epochs, 10.0, 75.0);

}

void mousePressed() {
  if (bestBtn.contains(mouseX, mouseY)) {
    population.showingBest = !population.showingBest;
  }
  if (speedBtn.contains(mouseX, mouseY)) {
    epochs = epochs%20 + 1;
  }
  if (restartBtn.contains(mouseX, mouseY)) {
    population = new Population(1000, goal, obstacles);
    println("GA Restart");
  }
}
