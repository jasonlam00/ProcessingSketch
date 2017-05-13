class Ball {

  float x;
  float y;
  float rad;
  color c;
  float dx;
  float dy;
  int state; // 0-moving, 1-expanding, 2-shrinking, 3-dead

  Ball() {
    x = random((width - rad) + rad / 2);
    y = random((height - rad) + rad / 2);
    rad = 20;
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    dx = random(10) - 5;
    dy = random(10) - 5;
    state = 0;
  }

  Ball(int newX, int newY, int newDx, int newDy, int newState) {
    this();
    x = newX;
    y = newY;
    dx = newDx;
    dy = newDy;
    state = newState;
  }

  void stopMoving() {
    if (state == 0) {
      dx = 0;
      dy = 0;
      state = 1;
    }
  }

  void move() {
    //System.out.println(state);
    if (state == 0) {
      x = x + dx;
      y = y + dy;
      bounce();
    } else if (state == 1) {
      //System.out.println("expand");
      expand();
    } else if (state == 2) {
      //System.out.println("shrink");
      shrink();
    }
  }

  void bounce() {
    if (x >= width || x <= 0) {
      dx = -dx;
    } else if (y >= height || y <= 0) {
      dy = -dy;
    }
  }

  void display() {
    fill(c);
    ellipse(x, y, rad, rad);
  }

  boolean collides(Ball other) {
    // For the initial ball and state 3 balls
    if ((state == 1 || other.state == 1) && (state != 3 && other.state != 3)) {
      float d = dist(x, y, other.x, other.y);
      return d < rad + other.rad - 50; // Almost touching
    }
    return false;
  }

  void expand() {
    if (rad < 175) {
      //System.out.println(rad);
      rad++;
    } else {
       state = 2;
    }
  }

  void shrink() {
    //System.out.println("SHRINK");
    if (rad >= 0) {
      rad--;
    } else {
      state = 3;
    }
  }

}
