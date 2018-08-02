/* Conversation.pde
 * 
 * Fairly simplified prototype for a modular NPC social interaction system.
 * Built as a cyclical wrapping queue for strings called blurbs.
 * 
 * J Karstin Neill    08.01.18
 */

public class Conversation {
  private final static int BLURBMAX = 16;
  
  private String[] mBlurbs;
  private int mBlurbCount;
  private int mCurrentBlurb;
  
  public Conversation() {
    mBlurbs = new String[BLURBMAX];
    for (int i=0; i < BLURBMAX; i++) mBlurbs[i] = null;
    mBlurbCount = 0;
    mCurrentBlurb = 0;
  }
  
  public String getNextBlurb() {
    if (mCurrentBlurb >= mBlurbCount) mCurrentBlurb = 0;
    return mBlurbs[mCurrentBlurb++];
  }
  
  public void addBlurb(String blurb) {
    if (mBlurbCount < BLURBMAX) mBlurbs[mBlurbCount++] = blurb;
  }
};
