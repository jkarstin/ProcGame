/* Scene.pde
 * 
 * Prototype to allow for modular scene changing and managing large collections of objects
 * 
 * J Karstin Neill    07.31.18
 */

public class Scene {
  final static int MAXOBJECTS = 1024;
  final static int MAXNPCS    = 32;
  final static int MAXITEMS   = 64;
  final static int MAXDOORS   = 64;
  
  private String mName;
  private int mID;
  
  private Collection<Object> mAllVisibleObjects;
  private Collection<Object> mAllPhysicalObjects;
  private Collection<NPC>    mAllNPCs;
  private Collection<Item>   mAllItems;
  private Collection<Door>   mAllDoors;
  
  public Scene(String name, int ID) {
    mName = name;
    mID = ID;
    
    mAllVisibleObjects  = new Collection<Object>(MAXOBJECTS);
    mAllPhysicalObjects = new Collection<Object>(MAXOBJECTS);
    mAllNPCs            = new Collection<NPC>(MAXNPCS);
    mAllItems           = new Collection<Item>(MAXITEMS);
    mAllDoors           = new Collection<Door>(MAXDOORS);
  }
  
  public String name() {
    return mName;
  }
  
  public int ID() {
    return mID;
  }
  
  public boolean hasName(String name) {
    return name == mName;
  }
  
  public boolean hasID(int ID) {
    return ID == mID;
  }
  
  public Object getVisibleObject(int index) {
    return mAllVisibleObjects.getElement(index);
  }
  
  public Object getPhysicalObject(int index) {
    return mAllPhysicalObjects.getElement(index);
  }
  
  public NPC getNPC(int index) {
    return mAllNPCs.getElement(index);
  }
  
  public Item getItem(int index) {
    return mAllItems.getElement(index);
  }
  
  public Door getDoor(int index) {
    return mAllDoors.getElement(index);
  }
  
  public Object removeVisibleObject(int index) {
    return mAllVisibleObjects.removeElement(index);
  }
  
  public Object removePhysicalObject(int index) {
    return mAllPhysicalObjects.removeElement(index);
  }
  
  public NPC removeNPC(int index) {
    return mAllNPCs.removeElement(index);
  }
  
  public Item removeItem(int index) {
    return mAllItems.removeElement(index);
  }
  
  public Door removeDoor(int index) {
    return mAllDoors.removeElement(index);
  }
  
  public void addVisibleObject(Object object) {
    mAllVisibleObjects.addElement(object);
  }
  
  public void addPhysicalObject(Object object) {
    mAllPhysicalObjects.addElement(object);
  }
  
  public void addNPC(NPC npc) {
    mAllNPCs.addElement(npc);
  }
  
  public void addItem(Item item) {
    mAllItems.addElement(item);
  }
  
  public void addDoor(Door door) {
    mAllDoors.addElement(door);
  }
  
  public void show() {
    background(0);
    for (int o=0; mAllVisibleObjects.getElement(o) != null; o++) mAllVisibleObjects.getElement(o).show();
  }
};
