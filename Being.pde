/* Being.pde
 * 
 * Intermediary class to represent entities which have more complex behaviour than simple Objects,
 * but which do not have the complete interaction capabilites of a full NPC.
 * Since the Player of the game does not need the complex features provided by the NPC class,
 * they actually fall into this category, and their movement is handled by an external input gathering system.
 * 
 * Currently very much in the conceptual stages of development. Better defined boundaries for the need of this particular
 * class will better determine what can be added to make it unique from simple Objects, while still providing a
 * foundation for NPC.
 * 
 * J Karstin Neill    07.27.18
 */

public class Being extends Object {
  //Wrapper Constructor
  public Being(String name, float x, float y, float w, float h) {
    super(name, x, y, w, h);
  }


};
