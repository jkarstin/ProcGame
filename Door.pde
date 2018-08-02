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
  
  public Door(String name, float x, float y, float w, float h, Scene destination) {
    super(name, x, y, w, h);
    mDestScene = destination;
    mLocked = false;
    mKey = null;
  }
  
  public Door(String name, float x, float y, float w, float h, Scene destination, boolean locked, Item keyItem) {
    super(name, x, y, w, h);
    mDestScene = destination;
    mLocked = locked;
    mKey = keyItem;
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
