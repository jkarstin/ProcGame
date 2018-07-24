public class Object {
  protected Coord mCoord;
  protected Coord mSize;
  protected Collider mCol;

  //public Object(float[] coord, float[] size) {
  //  mSize = size;
  //  mCoord = coord;
  //}
  
  //Constructor
  public Object(float x, float y, float w, float h) {
    mCoord = new Coord(x, y);
    mSize = new Coord(w, h);
    mCol = new Collider(x, y, w, h);
  }
  
  //Move the coordinates of object by given delta vector
  public void move(float[] deltaVect) {
    this.move(deltaVect[0], deltaVect[1]);
  }
  
  //Move the coordinates of object by given delta amounts
  public void move(float deltaX, float deltaY) {
    mCoord.plusEq(new Coord(deltaX, deltaY));
    mCoord.wrap(new Coord(), new Coord(width, height));
    mCol.move(deltaX, deltaY);
  }
  
  public Collider getCollider() {
    return mCol;
  }
  
  //Display object on screen
  public void show() {
    rect(mCoord.x(), mCoord.y(), mSize.x(), mSize.y());
  }
};
