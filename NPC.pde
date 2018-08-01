/* NPC.pde
 * 
 * J Karstin Neill    07.27.18
 */

public class NPC extends Being {
  private Conversation mConvo;
  private Timer mTopicShowTimer;
  private String mTopicText;
  
  public NPC(String name, float x, float y, float w, float h) {
    super(name, x, y, w, h);
    mConvo = new Conversation();
    mTopicShowTimer = new Timer(3);
    mTopicText = "";
  }
  
  public void interact() {
    mTopicShowTimer.begin();
    mTopicText = mConvo.getNextTopic().getPrompt();
  }
  
  public void addTopic(String topic) {
    mConvo.addTopic(topic);
  }
  
  //Override's super class show() with added speech bubble timing
  public void show() {
    super.show();
    if (mTopicShowTimer.isRunning() && !mTopicShowTimer.timedOut()) {
      fill(255);
      text(mTopicText, mCoord.x(), mCoord.y());
    } else if (mTopicShowTimer.timedOut()) mTopicShowTimer.halt();
  }
};
