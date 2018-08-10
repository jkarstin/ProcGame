/* ProcGame.pde
 * 
 * This is the main() equivalent of the program. The core unit, that controls the rest of the game.
 * Must remain the same name as the directory it is stored in, for Processing to understand this.
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
Object obj1;
Object obj2;
NPC npc1;
NPC npc2;

Inventory inv;
Item key1;
Item itm2;

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
  plyr = new     Being("Player",  20, 120, 20, 20);
  obj1 = new    Object(  "obj1",  20,  20, 40, 40);
  obj2 = new    Object(  "obj2",  80,  20, 40, 40);
  npc1 = new       NPC(   "Bob",  20, 200, 40, 40);
  npc2 = new       NPC(  "Mike",  20, 200, 40, 40);
  inv  = new Inventory(16);
  key1 = new      Item(  "key1", 120, 120, 10, 10);
  itm2 = new      Item(  "itm2", 400, 120, 10, 10);
  dor1 = new      Door( "door1", 600, 300, 30, 40, nextScene, new Coord(350, 210), true, key1);
  dor2 = new      Door( "door2", 400, 200, 30, 40, mainScene, new Coord(550, 310));

  //Give NPCs conversation topics
  npc1.addBlurb("Hello! How are you?");
  npc1.addBlurb("I'm doing pretty well.");
  npc1.addBlurb("Hello! How are you?");
  npc1.addBlurb("I'm doing pretty well.");
  npc1.addBlurb("What?");
  npc1.addBlurb("Don't you have something better to do?");
  npc1.addBlurb("This is not very productive...");
  npc1.addBlurb("It's dangerous to go alone.");
  npc1.addBlurb("...I have nothing to give you.");
  npc1.addBlurb("That's it, I'm pretending I don't know you.");
  
  npc2.addBlurb("I'm not who you think I am.");
  npc2.addBlurb("I've heard about you.");
  npc2.addBlurb("Bob was right, you are quite annoying.");
  npc2.addBlurb("*whistles as if you are not here*");
  npc2.addBlurb("Why don't you do yourself a favor...");
  npc2.addBlurb("...and go back through that door over there.");

  //Populate scenes
  mainScene.addVisibleObject(obj1);
  mainScene.addVisibleObject(obj2);
  mainScene.addVisibleObject(key1);
  mainScene.addVisibleObject(itm2);
  mainScene.addVisibleObject(dor1);
  mainScene.addVisibleObject(npc1);
  mainScene.addVisibleObject(plyr);
  mainScene.addVisibleObject(inv);
  mainScene.addPhysicalObject(obj1);
  mainScene.addPhysicalObject(obj2);
  mainScene.addPhysicalObject(npc1);
  mainScene.addNPC(npc1);
  mainScene.addItem(key1);
  mainScene.addItem(itm2);
  mainScene.addDoor(dor1);
  
  nextScene.addVisibleObject(dor2);
  nextScene.addVisibleObject(npc2);
  nextScene.addVisibleObject(plyr);
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

//Runs once upon any key press; key pressed stored in "key" variable
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
    //If a door was taken last iteration, stop looping
    if (tookDoor) break;
  }
} //end draw()
