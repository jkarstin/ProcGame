/* Inventory.pde
 * 
 * 
 * 
 * J Karstin Neill    07.31.18
 */

public class Inventory extends Object {
  private final static int SLOTSIZE = 40;
  private final static int WIDTH = 6;
  
  private Item[] mItems;
  private int mItemCount;
  private int mSlotCount;
  
  public Inventory(int slots) {
    super("Inventory", width-210, height-210, 200, 200);
    mItems = new Item[slots];
    for (int i=0; i < slots; i++) mItems[i] = null;
    mItemCount = 0;
    mSlotCount = slots;
  }
  
  public void addItem(Item item) {
    if (mItemCount < mSlotCount) {
      mItems[mItemCount++] = item;
    }
  }
  
  public Item getItem(int index) {
    if (index < mItemCount) {
      return mItems[index];
    }
    return null;
  }
  
  public void show() {
    super.show();
    for (int i=0; i < mItemCount; i++) {
      mItems[i].setLocation(this.location().x()+(i%WIDTH)*SLOTSIZE+(SLOTSIZE/2), this.location().y()+(i/WIDTH)*SLOTSIZE+(SLOTSIZE/2));
      mItems[i].show();
    }
  }
};
