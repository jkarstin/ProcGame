/* Collider.pde
 * 
 * Pseudo object-style class designed to specifically handle overlapping detection using basic geometric principles.
 * Currently only supports non-rotated rectangular geometry, but plans for triangular, elliptical, and polygon
 * collision implementation will be initiated and carried through if need arises.
 * 
 * J Karstin Neill    07.27.18
 */

public class Collider {
  //Private fields
  private Coord mCoord;
  private Coord mSize;

  //Public constructor method
  public Collider(float x, float y, float w, float h) {
    mCoord = new Coord(x, y);
    mSize = new Coord(w, h);
  }
  
  //Adds given delta coordinate to this collider's mCoord location coordinate to simulate movement
  public void move(Coord delta) {
    mCoord.plusEq(delta);
    mCoord.wrap(mSize.negate(), new Coord(width, height));
  }
  
  //Wrapper method for move(Coord)
  public void move(float deltaX, float deltaY) {
    this.move(new Coord(deltaX, deltaY));
  }
  
  //Returns true if given coordinate value lies within or touches this collider
  public boolean contains(Coord coord) {
    if (coord.x() >= mCoord.x()           &&
        coord.x() <= mCoord.x()+mSize.x() &&
        coord.y() >= mCoord.y()           &&
        coord.y() <= mCoord.y()+mSize.y()) {
      return true;
    }
    return false;
  }
  
  //Wrapper method for move(Coord)
  public boolean contains(float x, float y) {
    return contains(new Coord(x, y));
  }
  
  //Return coordinate value at center
  public Coord center() {
    return mCoord.plus(mSize.times(0.5));
  }
  
  //Return y coordinate value of top edge
  public float top() {
    return mCoord.y();
  }
  
  //Return x coordinate value of left edge
  public float left() {
    return mCoord.x();
  }
  
  //Return y coordinate value of bottom edge
  public float bottom() {
    return mCoord.y() + mSize.y();
  }
  
  //Return x coordinate value of right edge
  public float right() {
    return mCoord.x() + mSize.x();
  }
  
  //Return coordinate value of top left corner
  public Coord topLeft() {
    return mCoord;
  }
  
  //Return coordinate value of bottom right corner
  public Coord bottomRight() {
    return mCoord.plus(mSize);
  }
  
  //Returns true if this collider is overlapping or touching given other collider
  public boolean collidingWith(Collider other) {
    //Compare vertical edges
    if ((this.left()   >= other.left() && this.left()   <= other.right()) || //this  left  edge between other left and right edge
        (this.right()  >= other.left() && this.right()  <= other.right()) || //this  right edge between other left and right edge
        (other.left()  >= this.left()  && other.left()  <= this.right() ) || //other left  edge between this  left and right edge
        (other.right() >= this.left()  && other.right() <= this.right() )) { //other right edge between this  left and right edge
      //Compare horizontal edges
      if ((this.top()     >= other.top() && this.top()     <= other.bottom()) || //this  top    edge between other top and bottom edge
          (this.bottom()  >= other.top() && this.bottom()  <= other.bottom()) || //this  bottom edge between other top and bottom edge
          (other.top()    >= this.top()  && other.top()    <= this.bottom() ) || //other top    edge between this  top and bottom edge
          (other.bottom() >= this.top()  && other.bottom() <= this.bottom() )) { //other bottom edge between this  top and bottom edge
        return true;
      }
    }
    return false;
  }
};
