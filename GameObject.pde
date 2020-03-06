public abstract class GameObject{
  
  protected Rectangle rect;
  protected boolean isAlive;
  
  public GameObject(int l, int t, int w, int h){
    rect = new Rectangle(l, t, w, h);
  }
  
  public boolean isAlive(){
    return isAlive;
  }
  
  public void setAlive(boolean val){
    isAlive = val;
  }
  
  public Rectangle getRectangle(){
    return rect;
  }
  
  //abstract void draw();
  
}