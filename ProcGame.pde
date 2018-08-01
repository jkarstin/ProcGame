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
final float MOVESPEED  = 200;
final int   MAXOBJECTS = 1024;
final int   MAXNPCS    = 32;
final int   MAXITEMS   = 64;

Scene mainScene;
Scene currentScene;

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
long lastMillis;
float deltaTime;


//-------- SETUP --------//

//Setup function: run once at beginning of launch
void setup() {
  //Set up screen
  size(800, 600);

  //Initialize scenes
  mainScene = new Scene("Main", 0);

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

  //Populate scenes
  mainScene.addVisibleObject(obj1);
  mainScene.addVisibleObject(obj2);
  mainScene.addVisibleObject(itm1);
  mainScene.addVisibleObject(itm2);
  mainScene.addVisibleObject(npc1);
  mainScene.addVisibleObject(plyr);
  mainScene.addVisibleObject(inv);
  mainScene.addPhysicalObject(obj1);
  mainScene.addPhysicalObject(obj2);
  mainScene.addPhysicalObject(npc1);
  mainScene.addNPC(npc1);
  mainScene.addItem(itm1);
  mainScene.addItem(itm2);
  
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
      blocked = true; //Object is blocking movement
      break; //Stop searching for blocking objects
    }
  }
  if (blocked) blocked = false; //Reset blocked flag
  else plyr.move(moveVect.times(MOVESPEED*deltaTime)); //If blocked flag was not set, move
  

  
  //Process interaction if present
  if (interact) {
    //Reset flag
    interact = false;
    //Check for NPC collision in cardinal direction at distance of 40 from plyr center.
    for (int n=0; currentScene.getNPC(n) != null; n++) {
      if (currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord(  0, -40))) ||
          currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord( 40,   0))) ||
          currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord(  0,  40))) ||
          currentScene.getNPC(n).getCollider().contains(plyr.getCollider().center().plus(new Coord(-40,   0)))) {
        println(currentScene.getNPC(n).interact()); //If collision, interact
        break; //Stop searching for NPCs
      }
    }
  }
  
  //Pick up any touching items
  for (int i=0; currentScene.getItem(i) != null; i++) {
    //Do something
  }
  
  //Display scene
  currentScene.show();
} //end draw()
