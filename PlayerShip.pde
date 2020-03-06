public class PlayerShip extends GameObject{
  
  private int animationState;
  public PlayerShip(int l, int t, int w, int h){
    super(l, t, w, h);
  }
  
  public void draw(){
    color colorFill = color(0,34,123);
    
    if(animationState > 0){
      animationState++;
    
    if ((animationState/20)% 2 == 0){
      colorFill = color(255,0,0);
    }
    if(animationState == 120){ 
      animationState = 0;
    }
    }
    
     fill(0,50,200);
     noStroke();
     //In Klammern: Werte werden mit getter Methoden angefordert
     //rect(): Methode, die Rechtecke zeichnet
     rect(rect.getLeft(), rect.getTop(), rect.getWidth(), rect.getHeight());
  }
  
  public void moveLeft(){
    if (rect.getLeft() >= 8)
      rect = rect.move(-8, 0);
  }
  
  public void moveRight(){
    if (rect.getLeft()+rect.getWidth() <= width - 8)
      rect = rect.move(8, 0);
  }


public boolean  isProtected(){
  return animationState != 0;
}
public void activateHit(){
  animationState = 1;
}
}