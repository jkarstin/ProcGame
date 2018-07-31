/* Conversation.pde
 * 
 * J Karstin Neill    07.27.18
 */

public class Conversation {
  private final static int TOPICMAX = 16;
  
  private Topic[] mTopics;
  private int mTopicCount;
  private int mCurrentTopic;
  
  public Conversation() {
    mTopics = new Topic[TOPICMAX];
    for (int i=0; i < TOPICMAX; i++) mTopics[i] = null;
    mTopicCount = 0;
    mCurrentTopic = 0;
  }
  
  public Topic getNextTopic() {
    if (mCurrentTopic >= mTopicCount) mCurrentTopic = 0;
    return mTopics[mCurrentTopic++];
  }
  
  public void addTopic(String prompt) {
    if (mTopicCount < TOPICMAX) mTopics[mTopicCount++] = new Topic(prompt);
  }
};
