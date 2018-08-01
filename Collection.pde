/* Collection.pde
 * 
 * 
 * 
 * J Karstin Neill    08.01.18
 */

public class Collection<T extends Object> {
  private Object[] mElements;
  private int mSpace;
  private int mCount;
  private int mMax;
  
  public Collection() {
    mSpace = 1;
    mElements = new Object[mSpace];
    mElements[0] = null;
    mCount = 0;
    mMax = 0; //If mMax is set to zero, then no maximum exists
  }
  
  public Collection(int max) {
    mSpace = 1;
    mElements = new Object[mSpace];
    mElements[0] = null;
    mCount = 0;
    mMax = max;
  }
  
  public int count() {
    return mCount;
  }
  
  public int space() {
    return mSpace;
  }
  
  public void addElement(T element) {
    if (mMax > 0 && mSpace <= mMax) {
      if (mCount >= mSpace) grow();
      if (mCount < mSpace) mElements[mCount++] = element;
    }
  }
  
  public T getElement(int index) {
    if (index < mCount) return (T)mElements[index];
    return null;
  }
  
  private void grow() {
    int newSpace = mSpace*2;
    if (mMax > 0 && newSpace > mMax) newSpace = mMax;
    
    Object[] tmp = new Object[newSpace];
    for (int i=0; i < newSpace; i++) {
      if (i < mSpace) tmp[i] = mElements[i];
      else tmp[i] = null;
    }
    mElements = tmp;
    tmp = null;
    mSpace = newSpace;
  }
};
