/* Door.pde
 * 
 * 
 * 
 * J Karstin Neill 08.02.18
 */

public class Door extends Object {
  private Scene mDestScene;
  private boolean mLocked;
  private Item mKey;
  private Coord mSpawnLocation;
  
  public Door(String name, float x, float y, float w, float h, Scene destination, Coord spawn) {
    super(name, x, y, w, h);
    mDestScene = destination;
    mLocked = false;
    mKey = null;
    mSpawnLocation = spawn;
  }
  
  public Door(String name, float x, float y, float w, float h, Scene destination, Coord spawn, boolean locked, Item keyItem) {
    super(name, x, y, w, h);
    mDestScene = destination;
    mLocked = locked;
    mKey = keyItem;
    mSpawnLocation = spawn;
  }
  
  public Coord getSpawn() {
    return mSpawnLocation;
  }
  
  public boolean isLocked() {
    return mLocked;
  }
  
  public boolean unlock(Item keyItem) {
    if (mLocked) {
      if (mKey != null && keyItem == mKey) {
        mLocked = false;
      } else return false;
    }
    return true;
  }
  
  public Scene takeDoor() {
    if (!mLocked) return mDestScene;
    return null;
  }
};
