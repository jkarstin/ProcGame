/* Coord.pde
 * 
 * The skeletal system of the entire game world. A(n) (ideally) comprehensive base
 * structure to allow all world components to communicate and manipulate location and dimension.
 * 
 * J Karstin Neill    07.27.18
 */

public class Coord {
  float mX, mY;
  
  public Coord() {
    mX = 0;
    mY = 0;
  }
  
  public Coord(float x, float y) {
    mX = x;
    mY = y;
  }
  
  public void setX(float x) {
    mX = x;
  }
  
  public void setY(float y) {
    mY = y;
  }
  
  public float x() {
    return mX;
  }
  
  public float y() {
    return mY;
  }
  
  public Coord negate() {
    return this.times(-1);
  }
  
  public Coord plus(Coord other) {
    if (other != null) return new Coord(this.x() + other.x(), this.y() + other.y());
    return null;
  }
  
  public void plusEq(Coord other) {
    if (other != null) {
      this.mX += other.x();
      this.mY += other.y();
    }
  }
  
  public Coord times(float mult) {
    return new Coord(this.mX*mult, this.mY*mult);
  }
  
  public void cap(Coord TL, Coord BR) {
    //Minimum cap
    if (this.x() < TL.x()) this.mX = TL.x();
    if (this.y() < TL.y()) this.mY = TL.y();
    //Maximum cap
    if (this.x() > BR.x()) this.mX = BR.x();
    if (this.y() > BR.y()) this.mY = BR.y();
  }
  
  public void wrap(Coord TL, Coord BR) {
    //Minimum wrap to maximum
    if (this.x() < TL.x()) this.mX = BR.x()-(TL.x()-this.x());
    if (this.y() < TL.y()) this.mY = BR.y()-(TL.y()-this.y());
    //Maximum warp to minimum
    if (this.x() > BR.x()) this.mX = TL.x()+(this.x()-BR.x());
    if (this.y() > BR.y()) this.mY = TL.y()+(this.y()-BR.y());
  }
};
