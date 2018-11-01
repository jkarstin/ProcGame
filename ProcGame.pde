/* ProcGame.pde
 * 
 * This is the main() equivalent of the program. The core unit, that controls the rest of the game.
 * Must remain the same name as the directory it is stored in for Processing to compile correctly.
 * 
 * J Karstin Neill    07.27.18
 */


//-------- VARIABLES --------//

//Global constants
final float MOVESPEED  = 200; //rate of pixels/second player moves

Scene mainScene;
Scene nextScene;
Scene currentScene;

Being plyr;
Object wal1;
Object wal2;
Object wal3;
Object wal4;
NPC npc1;
NPC npc2;

Inventory inv;
Item key1;

Door dor1;
Door dor2;

Coord moveVect;
boolean blocked;
boolean interact;
long lastMillis;
float deltaTime;
boolean tookDoor;


//-------- SETUP --------//

//Setup function: run once at beginning of launch
void setup() {
  //Set up screen
  size(800, 600);

  //Initialize scenes
  mainScene = new Scene("Main", 0);
  nextScene = new Scene("next", 1);

  //Initialize objects
  plyr = new     Being("Player",  (width-20)/2,  (height-20)/2,       20,         20);
  wal1 = new    Object( "Wall1",            20,             20, width-80,         40);
  wal2 = new    Object( "Wall2",            20,             60,       40, height-180);
  wal3 = new    Object( "Wall3",            60,     height-160, width-80,         40);
  wal4 = new    Object( "Wall4",      width-60,             20,       40, height-180);
  npc1 = new       NPC(   "Bob",            80,            200,       40,         40);
  npc2 = new       NPC(  "Mike",           400,            100,       40,         40);
  inv  = new Inventory(16);
  key1 = new      Item(  "key1",           120,            120,       10,         10);
  dor1 = new      Door( "door1",      width-75, (height-140)/2,       30,         40, nextScene, new Coord(       80, (height-120)/2), true, key1);
  dor2 = new      Door( "door2",            45, (height-140)/2,       30,         40, mainScene, new Coord(width-100, (height-120)/2));

  //Give NPCs conversation topics
  npc1.addBlurb("Hello! How are you?");
  npc1.addBlurb("I'm doing pretty well.");
  npc1.addBlurb("My name is Bob!");
  npc1.addBlurb("What's that?");
  npc1.addBlurb("You want to get through that door over there?");
  npc1.addBlurb("It's locked, silly! You'll need that key!");
  
  npc2.addBlurb("I'm not who you think I am.");
  npc2.addBlurb("I've heard about you.");
  npc2.addBlurb("Bob was right, you are quite annoying.");
  npc2.addBlurb("*whistles as if you are not here*");
  npc2.addBlurb("Why don't you do yourself a favor...");
  npc2.addBlurb("...and go back through that door over there.");

  //Populate scenes
  mainScene.addVisibleObject(wal1);
  mainScene.addVisibleObject(wal2);
  mainScene.addVisibleObject(wal3);
  mainScene.addVisibleObject(wal4);
  mainScene.addVisibleObject(key1);
  mainScene.addVisibleObject(dor1);
  mainScene.addVisibleObject(npc1);
  mainScene.addVisibleObject(plyr);
  mainScene.addVisibleObject(inv);
  mainScene.addPhysicalObject(wal1);
  mainScene.addPhysicalObject(wal2);
  mainScene.addPhysicalObject(wal3);
  mainScene.addPhysicalObject(wal4);
  mainScene.addPhysicalObject(npc1);
  mainScene.addNPC(npc1);
  mainScene.addItem(key1);
  mainScene.addDoor(dor1);

  nextScene.addVisibleObject(wal1);
  nextScene.addVisibleObject(wal2);
  nextScene.addVisibleObject(wal3);
  nextScene.addVisibleObject(wal4);
  nextScene.addVisibleObject(dor2);
  nextScene.addVisibleObject(npc2);
  nextScene.addVisibleObject(plyr);
  nextScene.addVisibleObject(inv);
  nextScene.addPhysicalObject(wal1);
  nextScene.addPhysicalObject(wal2);
  nextScene.addPhysicalObject(wal3);
  nextScene.addPhysicalObject(wal4);
  nextScene.addPhysicalObject(npc2);
  nextScene.addNPC(npc2);
  nextScene.addDoor(dor2);
  
  //Initialize system variables
  blocked  = false;
  interact = false;
  moveVect = new Coord();
  lastMillis = millis();
  deltaTime  = 0;
  
  //Set current scene to starting value
  currentScene = mainScene;
} //end setup()


//-------- EXECUTION --------//

//Runs once upon any key press; char key-code for key pressed stored in "key" built-in variable
void keyPressed() {
  if      (key == 'a' || key == 'A') moveVect.setX(-1);
  else if (key == 'd' || key == 'D') moveVect.setX( 1);
  
  if      (key == 'w' || key == 'W') moveVect.setY(-1);
  else if (key == 's' || key == 'S') moveVect.setY( 1);
  
  if      (key == 'e' || key == 'E') interact = true;
} //end keyPressed()

//Runs once upon any key release; key pressed stored in "key" variable
void keyReleased() {
  if (((key == 'a' || key == 'A') && moveVect.x() < 0) ||
      ((key == 'd' || key == 'D') && moveVect.x() > 0)) {
    moveVect.setX(0);
  }
  if (((key == 'w' || key == 'W') && moveVect.y() < 0) ||
      ((key == 's' || key == 'S') && moveVect.y() > 0)) {
    moveVect.setY(0);
  }
} //end keyReleased()

//Runs once per frame of the game
void draw() {
  //Calculate amount of time since last draw() call, and store in deltaTime as seconds
  deltaTime  = (millis()-lastMillis)/1000.0;
  lastMillis = millis();
  
  //Most basic form of collision blocking. Preemptively stops center of player from entering Collider
  for (int o=0; currentScene.getPhysicalObject(o) != null; o++) {
    if (currentScene.getPhysicalObject(o).getCollider().contains(plyr.getCollider().center().plus(moveVect.times(MOVESPEED*deltaTime)))) {
      //Object is blocking movement, set blocked flag
      blocked = true;
      //Stop searching for blocking objects
      break;
    }
  }
  //If blocked flag is set, clear it for next frame
  if (blocked) blocked = false;
  //If blocked flag was not set, move player
  else plyr.move(moveVect.times(MOVESPEED*deltaTime));
  
  //Process player interaction if present
  if (interact) {
    //Reset flag
    interact = false;
    //Check for NPC collision in cardinal direction at distance of 40 from plyr center.
    for (int n=0; currentScene.getNPC(n) != null; n++) {
      if (currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord(  0, -40))) ||
          currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord( 40,   0))) ||
          currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord(  0,  40))) ||
          currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord(-40,   0)))) {
        currentScene.getNPC(n).interact();
        //Stop searching for NPCs
        break;
      }
    }
  }
  
  //Display scene
  currentScene.show();
  
  //Pick up any touching items
  for (int i=0; currentScene.getItem(i) != null; i++) {
    //Check for collision
    if (plyr.collidingWith(currentScene.getItem(i))) {
      //Search for item within currentScenes visible objects
      for (int o=0; currentScene.getVisibleObject(o) != null; o++)
        //Remove it from visible objects collection
        if (currentScene.getVisibleObject(o) == currentScene.getItem(i))
          currentScene.removeVisibleObject(o);
      //Remove the item from the scene and add it to inventory
      inv.addItem(currentScene.removeItem(i));
    }
  }
  
  //Use doors
  tookDoor = false; //Flag to reduce door algorithm iteration count
  for (int d=0; currentScene.getDoor(d) != null; d++) {
    //Check for collision
    if (plyr.collidingWith(currentScene.getDoor(d))) {
      //Try each inventory item as a key on door
      for (int k=0; inv.getItem(k) != null; k++) {
        //Note: Door.unlock(Item) always returns true if the door is not locked in the first place
        if (currentScene.getDoor(d).unlock(inv.getItem(k))) {
          //If door has been unlocked, ensure it leads somewhere
          if (currentScene.getDoor(d).takeDoor() != null) {
            //Change player location to spawn point determined by door
            plyr.setLocation(currentScene.getDoor(d).getSpawn());
            //Change current scene to location scene given by door
            currentScene = currentScene.getDoor(d).takeDoor();
            //Stop looking for doors this frame
            tookDoor = true;
          }
          break; //Stop looking for a key
        }
      }
    }
    //If currentScene.getDoor(d) was taken, stop looping
    if (tookDoor) break;
  }
} //end draw()
