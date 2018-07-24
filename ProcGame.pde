Object obj1;
Object obj2;
Player plyr;
Coord moveVect;

final float moveSpeed = 5;

void setup() {
  size(800, 600);
  
  obj1 = new Object(20, 20, 40, 40);
  obj2 = new Object(80, 20, 40, 40);
  plyr = new Player(20, 120, 20, 40);
  
  moveVect = new Coord();
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    moveVect.setX(-1);
  } else if (key == 'd' || key == 'D') {
    moveVect.setX(1);
  }
  if (key == 'w' || key == 'W') {
    moveVect.setY(-1);
  } else if (key == 's' || key == 'S') {
    moveVect.setY(1);
  }
}

void keyReleased() {
  if (((key == 'a' || key == 'A') && moveVect.x() < 0) ||
      ((key == 'd' || key == 'D') && moveVect.x() > 0)) {
    moveVect.setX(0);
  }
  if (((key == 'w' || key == 'W') && moveVect.y() < 0) ||
      ((key == 's' || key == 'S') && moveVect.y() > 0)) {
    moveVect.setY(0);
  }
}

void draw() {
  background(0);
  obj1.show();
  obj2.show();
  //plyr.move(5, 2);
  plyr.move(moveVect.times(moveSpeed));
  plyr.show();
  if (plyr.collidingWith(obj1)) println("Player colliding with obj1!");
  if (plyr.collidingWith(obj2)) println("Player colliding with obj2!");
}
