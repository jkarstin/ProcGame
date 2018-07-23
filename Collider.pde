public class Collider {
  float[] mCoord;
  float[] mSize;

  public Collider(float x, float y, float w, float h) {
    mCoord = new float[2];
    mSize = new float[2];
    mCoord[0] = x;
    mCoord[1] = y;
    mSize[0] = w;
    mSize[1] = h;
  }
  
  public void move(float deltaX, float deltaY) {
    mCoord[0] += deltaX;
    mCoord[1] += deltaY;
    mCoord[0] = wrap(mCoord[0], 0, width);
    mCoord[1] = wrap(mCoord[1], 0, height);
  }
  
  public boolean contains(float[] coord) {
    return contains(coord[0], coord[1]);
  }
  
  public boolean contains(float x, float y) {
    if (x >= mCoord[0] &&
        x <= mCoord[0]+mSize[0] &&
        y >= mCoord[1] &&
        y <= mCoord[1]+mSize[1]) {
      return true;
    }
    return false;
  }
  
  public void topLeft(float[] container) {
    if (container != null) {
      container[0] = mCoord[0];
      container[1] = mCoord[1];
    }
  }
  
  public void topRight(float[] container) {
    if (container != null) {
      container[0] = mCoord[0]+mSize[0];
      container[1] = mCoord[1];
    }
  }
  
  public void bottomLeft(float[] container) {
    if (container != null) {
      container[0] = mCoord[0];
      container[1] = mCoord[1]+mSize[1];
    }
  }
  
  public void bottomRight(float[] container) {
    if (container != null) {
      container[0] = mCoord[0]+mSize[0];
      container[1] = mCoord[1]+mSize[1];
    }
  }
  
  //Gives value capped between two endpoints.
  //  If value is less than minimum, cap at minimum.
  //  If value is greater than maximum, cap at maximum.
  private float cap(float val, float min, float max) {
    if (val < min) return min;
    if (val > max) return max;
    return val;
  }
  
  //Gives value wrapped between two endpoints.
  //  If value is less than minimum, wrap around to maximum.
  //  If value is greater than maximum, wrap around to minimum.
  private float wrap(float val, float min, float max) {
    if (val < min) return max-(min-val);
    if (val > max) return min+(val-max);
    return val;
  }
};
