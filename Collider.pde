public class Collider {
  private Coord mCoord;
  private Coord mSize;

  public Collider(float x, float y, float w, float h) {
    mCoord = new Coord(x, y);
    mSize = new Coord(w, h);
  }
  
  public void move(Coord delta) {
    mCoord.plusEq(delta);
    mCoord.wrap(mSize.negate(), new Coord(width, height));
  }
  
  public void move(float deltaX, float deltaY) {
    this.move(new Coord(deltaX, deltaY));
  }
  
  public boolean contains(Coord coord) {
    if (coord.x() >= mCoord.x()           &&
        coord.x() <= mCoord.x()+mSize.x() &&
        coord.y() >= mCoord.y()           &&
        coord.y() <= mCoord.y()+mSize.y()) {
      return true;
    }
    return false;
  }
  
  public boolean contains(float x, float y) {
    return contains(new Coord(x, y));
  }
  
  public float top() {
    return mCoord.y();
  }
  
  public float left() {
    return mCoord.x();
  }
  
  public float bottom() {
    return mCoord.y() + mSize.y();
  }
  
  public float right() {
    return mCoord.x() + mSize.x();
  }
  
  public Coord topLeft() {
    return mCoord;
  }
  
  public Coord bottomRight() {
    return mCoord.plus(mSize);
  }
  
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
