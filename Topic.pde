/* Topic.pde
 * 
 * J Karstin Neill    07.27.18
 */

public class Topic {
  //private final static int RESPONSEMAX = 4;
  
  private String mPrompt;
  //private String[] mResponses;
  //private int mResponseCount;
  
  public Topic(String prompt) {
    mPrompt = prompt;
    //mResponses = new String[RESPONSEMAX];
    //mResponseCount = 0;
  }
  
  //public void addResponse(String response) {
  //  if (mResponseCount < RESPONSEMAX) {
  //    mResponses[mResponseCount++] = response;
  //  }
  //}
  
  public String getPrompt() {
    return mPrompt;
  }
  
  //public String getResponse(int index) {
  //  if (index < mResponseCount) {
  //    return mResponses[index];
  //  }
  //  return null;
  //}
};
