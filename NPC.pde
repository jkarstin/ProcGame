/* NPC.pde
 * 
 * J Karstin Neill    07.27.18
 */

public class NPC extends Being {
  private Conversation mConvo;
  
  public NPC(String name, float x, float y, float w, float h) {
    super(name, x, y, w, h);
    mConvo = new Conversation();
  }
  
  public String interact() {
    return mConvo.getNextTopic().getPrompt();
  }
  
  public void addTopic(String topic) {
    mConvo.addTopic(topic);
  }
};
