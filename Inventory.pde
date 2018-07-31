public class Inventory {
  private final static int MAXITEMS = 32;
  
  private Item[] mItems;
  private int mItemCount;
  
  public Inventory() {
    mItems = new Item[MAXITEMS];
    for (int i=0; i < MAXITEMS; i++) mItems[i] = null;
    mItemCount = 0;
  }
  
  public void addItem(Item item) {
    if (mItemCount < MAXITEMS) {
      mItems[mItemCount++] = item;
    }
  }
  
  public Item getItem(int index) {
    if (index < mItemCount) {
      return mItems[index];
    }
    return null;
  }
};
