public class Object {
  protected Coord mCoord;
  protected Coord mSize;
  protected Collider mCol;
  
  //Constructor
  public Object(float x, float y, float w, float h) {
    mCoord = new Coord(x, y);
    mSize = new Coord(w, h);
    mCol = new Collider(x, y, w, h);
  }
  
  //Move the coordinates of object by given delta vector
  public void move(Coord delta) {
    mCoord.plusEq(delta);
    mCoord.wrap(mSize.negate(), new Coord(width, height));
    mCol.move(delta);
  }
  
  //Move the coordinates of object by given delta amounts
  public void move(float deltaX, float deltaY) {
    this.move(new Coord(deltaX, deltaY));
  }
  
  public Collider getCollider() {
    return mCol;
  }
  
  public boolean collidingWith(Object other) {
    return this.mCol.collidingWith(other.getCollider());
  }
  
  //Display object on screen
  public void show() {
    rect(mCoord.x(), mCoord.y(), mSize.x(), mSize.y());
  }
};
