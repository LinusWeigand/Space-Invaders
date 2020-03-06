public class AlienShip extends GameObject{
  public AlienShip(int l, int t, int w, int h){
    super(l, t, w, h);
    isAlive = true;
  }
  
  public void draw(){
    if(isAlive){
      if(rect.getTop() < 200){
        //gruen
        fill(0,255,0);
      }else if(rect.getTop() < 300){
        //tuerkis
        fill(0,255,240);
      }else if(rect.getTop() < 400){
        //lila
        fill(255,0,200);
      }else{
        //gelb
        fill(255,100, 0);
      }
      noStroke();
      ellipseMode(CORNER);
      ellipse(rect.getLeft(), rect.getTop(), rect.getWidth(), rect.getHeight());
    }
  }
  
  public void move(int xDiff, int yDiff){
   rect = rect.move(xDiff, yDiff); 
  }
}
/**
 
    
*/