class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  Goal goal;
  Obstacle[] obstacle;
  
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  float fitness = 0.0;

  Dot(Goal _goal, Obstacle[] _obstacles) {
    brain = new Brain(400);
    
    pos = new PVector(width/2, height - 10);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    
    goal = _goal;
    obstacles = _obstacles;
  }
  
  void show() {
    if (isBest) {
      fill(0,255,0);
      ellipse(pos.x,pos.y,4,4);
    } else {
      fill(0);
      ellipse(pos.x,pos.y,4,4);
    }
  }
  
  void move() {
    
    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true;
    }
    
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
    
  }
  
  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x < 2 || pos.y < 2 || pos.x>width-2 || pos.y > height -2) {
        dead = true;
      } else if (pow(goal.pos.x-pos.x,2) + pow(goal.pos.y-pos.y,2) < 5*5+4*4) {
        reachedGoal = true;
      }
      for(int i = 0; i < obstacles.length; i++) {
        if (obstacles[i].contains(pos)) {
          dead = true;
        }
      }
    }
  }
  
  void calculateFitness() {
    if (reachedGoal) {
      fitness = 1.0/16.0 + 1000.0/(float)(brain.step*brain.step);
    } else {
      float distanceToGoal = dist(pos.x,pos.y,goal.pos.x, goal.pos.y);
      fitness = 1.0 / (distanceToGoal * distanceToGoal);
    }
  }
  
  Dot reproduce() {
    Dot baby = new Dot(goal, obstacles);
    baby.brain = brain.clone();
    return baby;
  }

}
