/* Object.pde
 * 
 * J Karstin Neill    07.27.18
 */

public class Object {
  //Protected fields
  protected Coord mCoord;
  protected Coord mSize;
  protected Collider mCol;
  protected String mName;
  protected int mID;
  
  //Public constructor method
  public Object(String name, float x, float y, float w, float h) {
    mName = name;
    mCoord = new Coord(x, y);
    mSize = new Coord(w, h);
    mCol = new Collider(x, y, w, h);
  }
  
  //Return name of object
  public String name() {
    return mName;
  }
  
  //Adds given delta coordinate to this collider's mCoord location coordinate to simulate movement
  public void move(Coord delta) {
    mCoord.plusEq(delta);
    mCoord.wrap(mSize.negate(), new Coord(width, height));
    mCol.move(delta);
  }
  
  //Wrapper method for move(Coord)
  public void move(float deltaX, float deltaY) {
    this.move(new Coord(deltaX, deltaY));
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
    rect(mCoord.x(), mCoord.y(), mSize.x(), mSize.y());
  }
};
