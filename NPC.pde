/* NPC.pde
 * 
 * J Karstin Neill    07.27.18
 */

public class NPC extends Being {
  private final static float BLURBSHOWTIME = 3;
  
  private Conversation mConvo;
  private Timer mBlurbShowTimer;
  private String mCurrentBlurb;
  
  public NPC(String name, float x, float y, float w, float h) {
    super(name, x, y, w, h);
    mConvo = new Conversation();
    mBlurbShowTimer = new Timer(BLURBSHOWTIME);
    mCurrentBlurb = "";
  }
  
  public void interact() {
    mBlurbShowTimer.begin();
    mCurrentBlurb = mConvo.getNextBlurb();
  }
  
  public void addBlurb(String blurb) {
    mConvo.addBlurb(blurb);
  }
  
  //Override's super class show() with added speech bubble timing
  public void show() {
    super.show();
    if (mBlurbShowTimer.isRunning() && !mBlurbShowTimer.timedOut()) {
      fill(255);
      rect(mTransform.location().x(), mTransform.location().y()-30, 250, 30);
      fill(0);
      text(mCurrentBlurb, mTransform.location().x()+10, mTransform.location().y()-10);
    } else if (mBlurbShowTimer.timedOut()) mBlurbShowTimer.halt();
  }
};
