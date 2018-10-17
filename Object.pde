/* Object.pde
 * 
 * J Karstin Neill    07.27.18
 */

public class Object {
  //Protected fields
  protected Transform mTransform;
  protected Coord mSize;
  protected Collider mCol;
  protected String mName;
  protected int mID;
  
  //Public constructor method
  public Object(String name, float x, float y, float w, float h) {
    mName = name;
    mTransform = new Transform(new Coord(x, y), new Coord(0, 0), new Coord(1, 1));
    mSize = new Coord(w, h);
    mCol = new Collider(x, y, w, h);
  }
  
  public Coord location() {
    return mTransform.location();
  }
  
  //Return name of object
  public String name() {
    return mName;
  }
  
  //Adds given delta coordinate to this collider's mCoord location coordinate to simulate movement
  public void move(Coord delta) {
    mTransform.location().plusEq(delta);
    mTransform.location().wrap(mSize.negate(), new Coord(width, height));
    mCol.move(delta);
  }
  
  //Wrapper method for move(Coord)
  public void move(float deltaX, float deltaY) {
    move(new Coord(deltaX, deltaY));
  }
  
  public void setLocation(Coord location) {
    Coord delta = location.minus(mTransform.location());
    move(delta);
    mCol.setLocation(location);
  }
  
  public void setLocation(float x, float y) {
    this.setLocation(new Coord(x, y));
  }
  
  //Returns reference to private mCol collider field
  public Collider getCollider() {
    return mCol;
  }
  
  //Wrapper method for mCol.collidingWith(Collider)
  public boolean collidingWith(Object other) {
    return this.mCol.collidingWith(other.getCollider());
  }
  
  //Display object on screen
  public void show() {
    fill(255);
    rect(mTransform.location().x(), mTransform.location().y(), mSize.x(), mSize.y());
  }
};
