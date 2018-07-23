public class Object {
  protected float[] mCoord;
  protected float[] mSize;
  protected Collider mCol;

  //public Object(float[] coord, float[] size) {
  //  mSize = size;
  //  mCoord = coord;
  //}
  
  //Constructor
  public Object(float x, float y, float w, float h) {
    mCoord = new float[2];
    mCoord[0] = x;
    mCoord[1] = y;
    mSize = new float[2];
    mSize[0] = w;
    mSize[1] = h;
    mCol = new Collider(x, y, w, h);
  }
  
  //Move the coordinates of object by given delta vector
  public void move(float[] deltaVect) {
    this.move(deltaVect[0], deltaVect[1]);
  }
  
  //Move the coordinates of object by given delta amounts
  public void move(float deltaX, float deltaY) {
    mCoord[0] += deltaX;
    mCoord[1] += deltaY;
    mCoord[0] = wrap(mCoord[0], 0, width);
    mCoord[1] = wrap(mCoord[1], 0, height);
    mCol.move(deltaX, deltaY);
  }
  
  public Collider getCollider() {
    return mCol;
  }
  
  //Display object on screen
  public void show() {
    rect(mCoord[0], mCoord[1], mSize[0], mSize[1]);
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
