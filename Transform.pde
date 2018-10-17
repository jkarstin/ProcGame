public class Transform {
  private Transform mParent;
  private Coord mLocation;
  private Coord mRotation;
  private Coord mScale;
  
  public Transform(Coord loc, Coord rot, Coord scl) {
    mParent = null;
    mLocation = loc;
    mRotation = rot;
    mScale = scl;
  }
  
  public void setLocation(Coord loc) {
    mLocation = loc;
  }
  
  public void setRotation(Coord rot) {
    mRotation = rot;
  }
  
  public void setScale(Coord scl) {
    mScale = scl;
  }
  
  public void setParent(Transform p) {
    mParent = p;
  }
  
  public Coord location() {
    return mLocation;
  }
  
  public Coord rotation() {
    return mRotation;
  }
  
  public Coord scale() {
    return mScale;
  }
  
  public Transform parent() {
    return mParent;
  }
};
