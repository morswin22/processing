class Population {
  Dot[] dots;
  Goal goal;
  Obstacle[] obstacles;
  int gen = 0;
  
  int bestDot = 0;
  int minStep = 400;
  
  float fitnessSum;
  
  boolean showingBest = false;
  
  Population(int size, Goal _goal, Obstacle[] _obstacles) {
    dots = new Dot[size];
    goal = _goal;
    obstacles = _obstacles;
    for(int i = 0; i < size; i++) {
      dots[i] = new Dot(goal, obstacles);
    }
  }
  
  void show() {
    goal.show();
    for(int i = 0; i < obstacles.length; i++) {
      obstacles[i].show();
    }
    if (!showingBest) {
      for(int i = 0; i < dots.length; i++) {
        dots[i].show();
      }
    }
    dots[0].show();
  }
  
  void update() {
    for(int i = 0; i < dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
  }
  
  void calculateFitness() {
    for(int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }
  
  boolean allDotsDead() {
    for(int i = 0; i < dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }
  
  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    newDots[0] = dots[bestDot].reproduce();
    newDots[0].isBest = true;
    for (int i = 1; i < newDots.length; i++) {
      // select parent based on fitness
      Dot parent = selectParent();
      // new baby from parent
      newDots[i] = parent.reproduce();
    }
    
    dots = newDots;
    gen++;
  }
  
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i < dots.length; i++) {
      fitnessSum = dots[i].fitness;
    }
  }
  
  Dot selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;
    for (int i = 0; i < dots.length; i++) {
      runningSum += dots[i].fitness;
      if(runningSum > rand) {
        return dots[i];
      }
    }
    return null;
  }
  
  void mutate() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }
  
  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    
    bestDot = maxIndex;
    
    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      println("gen: ", gen); 
      println("step: ", minStep); 
    }
  }

}
