/* ProcGame.pde
 * 
 * This is the main() equivalent of the program. The core unit, that controls the rest of the game.
 * Must remain the same name as the directory it is stored in, for Processing to understand this.
 * 
 * TODO: Develop basic inventory system
 * 
 * J Karstin Neill    07.27.18
 */


//-------- VARIABLES --------//

//Global constants
final float MOVESPEED  = 5;
final int   MAXOBJECTS = 1024;
final int   MAXNPCS    = 32;
final int   MAXITEMS   = 64;

//System variables and data structures
Object[] allVisibleObjects;
int visObjCount;
Object[] allPhysicalObjects;
int objectCount;
NPC[] allNPCs;
int npcCount;
Item[] allItems;
int itemCount;

Being plyr;
Object obj1;
Object obj2;
NPC npc1;

Inventory inv;
Item itm1;
Item itm2;

Coord moveVect;
boolean blocked;
boolean interact;


//-------- SETUP --------//

//Setup function: run once at beginning of launch
void setup() {
  //Set up screen
  size(800, 600);

  //Initialize housekeeping arrays
  allVisibleObjects = new Object[MAXOBJECTS];
  visObjCount       = 0;
  allPhysicalObjects  = new Object[MAXOBJECTS];
  objectCount         = 0;
  allNPCs  = new NPC[MAXNPCS];
  npcCount = 0;
  allItems  = new Item[MAXITEMS];
  itemCount = 0;
  for (int i=0; i < MAXOBJECTS; i++) allVisibleObjects[i]  = null;
  for (int i=0; i < MAXOBJECTS; i++) allPhysicalObjects[i] = null;
  for (int i=0; i < MAXNPCS;    i++) allNPCs[i]            = null;
  for (int i=0; i < MAXITEMS;   i++) allItems[i]           = null;

  //Initialize objects
  plyr = new     Being("Player",  20, 120, 20, 20);
  obj1 = new    Object(  "obj1",  20,  20, 40, 40);
  obj2 = new    Object(  "obj2",  80,  20, 40, 40);
  npc1 = new       NPC(   "Bob",  20, 200, 40, 40);
  inv  = new Inventory();
  itm1 = new      Item("square", 120, 120, 10, 10);
  itm2 = new      Item("square", 400, 120, 10, 10);

  //Give NPCs conversation topics
  npc1.addTopic("Hello! How are you?");
  npc1.addTopic("I'm doing pretty well.");

  //Populate housekeeping arrays
  allVisibleObjects[visObjCount++] = obj1;
  allVisibleObjects[visObjCount++] = obj2;
  allVisibleObjects[visObjCount++] = itm1;
  allVisibleObjects[visObjCount++] = itm2;
  allVisibleObjects[visObjCount++] = npc1;
  allVisibleObjects[visObjCount++] = plyr;
  allVisibleObjects[visObjCount++] = inv;
  allPhysicalObjects[objectCount++] = obj1;
  allPhysicalObjects[objectCount++] = obj2;
  allPhysicalObjects[objectCount++] = npc1;
  allNPCs[npcCount++] = npc1;
  allItems[itemCount++] = itm1;
  allItems[itemCount++] = itm2;
  
  //Initialize system variables
  blocked  = false;
  interact = false;
  moveVect = new Coord();
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
  //Draw background over last frame's draw() call
  background(0);
  
  //Most basic form of collision blocking. Preemptively stops center of player from entering Collider
  for (int o=0; o < objectCount; o++) {
    if (allPhysicalObjects[o].getCollider().contains(plyr.getCollider().center().plus(moveVect.times(MOVESPEED)))) {
      blocked = true; //Object is blocking movement
      break; //Stop searching for blocking objects
    }
  }
  if (blocked) blocked = false; //Reset blocked flag
  else plyr.move(moveVect.times(MOVESPEED)); //If blocked flag was not set, move
  
  //Display visible objects
  for (int o=0; o < visObjCount; o++) allVisibleObjects[o].show();
  
  //Process interaction if present
  if (interact) {
    //Reset flag
    interact = false;
    //Check for NPC collision in cardinal direction at distance of 40 from plyr center.
    for (int n=0; n < npcCount; n++) {
      if (allNPCs[n].getCollider().contains(plyr.getCollider().center().plus(new Coord(  0, -40))) ||
          allNPCs[n].getCollider().contains(plyr.getCollider().center().plus(new Coord( 40,   0))) ||
          allNPCs[n].getCollider().contains(plyr.getCollider().center().plus(new Coord(  0,  40))) ||
          allNPCs[n].getCollider().contains(plyr.getCollider().center().plus(new Coord(-40,   0)))) {
        println(allNPCs[n].interact()); //If collision, interact
        break; //Stop searching for NPCs
      }
    }
  }
  
  //Pick up any touching items
  for (int i=0; i < itemCount; i++) {
    //Do something
  }
} //end draw()
