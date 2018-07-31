/* Scene.pde
 * 
 * Prototype to allow for modular scene changing and managing large collections of objects
 * 
 * J Karstin Neill    07.31.18
 */

public class Scene {
  final static int   MAXOBJECTS = 1024;
  final static int   MAXNPCS    = 32;
  final static int   MAXITEMS   = 64;
  
  private String mName;
  private int mID;
  
  private Object[] mAllVisibleObjects;
  private int      mVisObjCount;
  private Object[] mAllPhysicalObjects;
  private int      mObjectCount;
  private NPC[]    mAllNPCs;
  private int      mNpcCount;
  private Item[]   mAllItems;
  private int      mItemCount;
  
  public Scene(String name, int ID) {
    mName = name;
    mID = ID;
    
    mAllVisibleObjects   = new Object[MAXOBJECTS];
    mVisObjCount         = 0;
    mAllPhysicalObjects  = new Object[MAXOBJECTS];
    mObjectCount         = 0;
    mAllNPCs             = new NPC[MAXNPCS];
    mNpcCount            = 0;
    mAllItems            = new Item[MAXITEMS];
    mItemCount           = 0;
    for (int i=0; i < MAXOBJECTS; i++) mAllVisibleObjects[i]  = null;
    for (int i=0; i < MAXOBJECTS; i++) mAllPhysicalObjects[i] = null;
    for (int i=0; i < MAXNPCS;    i++) mAllNPCs[i]            = null;
    for (int i=0; i < MAXITEMS;   i++) mAllItems[i]           = null;
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
    if (index < mVisObjCount) return mAllVisibleObjects[index];
    return null;
  }
  
  public Object getPhysicalObject(int index) {
    if (index < mObjectCount) return mAllPhysicalObjects[index];
    return null;
  }
  
  public NPC getNPC(int index) {
    if (index < mNpcCount) return mAllNPCs[index];
    return null;
  }
  
  public Item getItem(int index) {
    if (index < mItemCount) return mAllItems[index];
    return null;
  }
  
  public void addVisibleObject(Object object) {
    if (mVisObjCount < MAXOBJECTS) mAllVisibleObjects[mVisObjCount++] = object;
  }
  
  public void addPhysicalObject(Object object) {
    if (mObjectCount < MAXOBJECTS) mAllPhysicalObjects[mObjectCount++] = object;  }
  
  public void addNPC(NPC npc) {
    if (mNpcCount < MAXNPCS) mAllNPCs[mNpcCount++] = npc;
  }
  
  public void addItem(Item item) {
    if (mItemCount < MAXITEMS) mAllItems[mItemCount++] = item;
  }
  
  public void show() {
    background(0);
    for (int o=0; o < mVisObjCount; o++) mAllVisibleObjects[o].show();
  }
};
