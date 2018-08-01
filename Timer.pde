/* Timer.pde
 * 
 * A small timing module that allows for precision timing within loops without delaying anything else within the loop.
 * 
 * J Karstin Neill    08.01.18
 */

public class Timer {
  private float mWaitTime;
  private boolean mRunning;
  private long mLastMillis;
  private long mRunMillis;
  
  public Timer(float waitTime) {
    mWaitTime = waitTime;
    this.reset();
  }
  
  public void setWaitTime(float waitTime) {
    mWaitTime = waitTime;
  }
  
  public boolean isRunning() {
    return mRunning;
  }
  
  public void begin() {
    this.reset();
    mRunning = true;
    mLastMillis = millis();
  }
  
  public void resume() {
    if (!mRunning) {
      mRunning = true;
      mLastMillis = millis();
    }
  }
  
  public void halt() {
    mRunning = false;
    this.reset();
  }
  
  public void reset() {
    mRunMillis = 0;
  }
  
  public void pause() {
    if (mRunning) {
      mRunning = false;
      this.update();
    }
  }
  
  public boolean timedOut() {
    if (mRunning) this.update();
    if (mRunMillis >= mWaitTime*1000) return true;
    return false;
  }
  
  private void update() {
    mRunMillis += millis()-mLastMillis;
    mLastMillis = millis();
  }
};
