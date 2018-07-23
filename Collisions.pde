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
    float[] TL = new float[2];
    float[] TR = new float[2];
    float[] BL = new float[2];
    float[] BR = new float[2];
    for (int i=0; i < count; i++) {
      for (int j=0; j < count; j++) {
        if (j != i) {
          mColliders[j].topLeft(TL);
          mColliders[j].topRight(TR);
          mColliders[j].bottomLeft(BL);
          mColliders[j].bottomRight(BR);
          if (mColliders[i].contains(TL) ||
              mColliders[i].contains(TR) ||
              mColliders[i].contains(BL) ||
              mColliders[i].contains(BR)) return true;
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
