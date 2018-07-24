public class Collisions {
  private Collider[] mColliders;
  private int count;
  
  public Collisions() {
    mColliders = new Collider[256];
    for (int i=0; i < 256; i++) {
      mColliders[i] = null;
    }
    count = 0;
  }
  
  public boolean hasCollisions() {
    for (int i=0; i < count; i++) {
      for (int j=0; j < count; j++) {
        if (j != i) {
          if (mColliders[i].collidingWith(mColliders[j])) return true;
        }
      }
    }
    return false;
  }
  
  public void addCollider(Collider c) {
    if (count < 256) {
      mColliders[count++] = c;
    } else {
      println("ERROR! Collisions collider collection at capacity!");
    }
  }
};
