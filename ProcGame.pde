Object obj1;
Object obj2;
Player plyr;
Collisions col;
Coord moveVect;

void setup() {
  size(800, 600);
  
  obj1 = new Object(20, 20, 40, 40);
  obj2 = new Object(80, 20, 40, 40);
  plyr = new Player(20, 120, 20, 40);
  
  col = new Collisions();
  col.addCollider(obj1.getCollider());
  col.addCollider(obj2.getCollider());
  col.addCollider(plyr.getCollider());
  
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
  if ((key == 'a' || key == 'A') && moveVect.x() < 0) {
    moveVect.setX(0);
  } else if ((key == 'd' || key == 'D') && moveVect.x() > 0) {
    moveVect.setX(0);
  }
  
  if ((key == 'w' || key == 'W') && moveVect.y() < 0) {
    moveVect.setY(0);
  } else if ((key == 's' || key == 'S') && moveVect.y() > 0) {
    moveVect.setY(0);
  }
}

void draw() {
  background(0);
  obj1.show();
  obj2.show();
  plyr.move(moveVect);
  plyr.show();
  if (plyr.getCollider().collidingWith(obj1.getCollider())) println("Player colliding with obj1!");
  if (plyr.getCollider().collidingWith(obj2.getCollider())) println("Player colliding with obj2!");
}
