public class Rectangle{
  private int rLeft, rTop, rWidth, rHeight;

  public Rectangle(int l, int t, int w, int h){
    rLeft = l;
    rTop = t;
    rWidth = w;
    rHeight = h;
  }
  
  public boolean intersects(Rectangle rect){
    //Rechteck A und Rechteck B
    
    if(rLeft > rect.rLeft + rect.rWidth){
      return false;  //A.links > B.rechts
    }else if(rLeft + rWidth < rect.rLeft){
      return false;  //A.rechts < B.links
    }else if(rTop > rect.rTop  + rect.rHeight){
      return false;  //A.oben > B.unten
    }else if(rTop + rHeight < rect.rTop){
      return false;  //A.unten < B.oben
    }else{
      return true;
    }
  }
  
  //Verschiebe Rechteck
  public Rectangle move(int diffX, int diffY){
    return new Rectangle(rLeft + diffX, rTop + diffY, rWidth, rHeight);
  }
  
  
  public int getLeft(){
    return rLeft;
  }
  
  public int getTop(){
    return rTop;
  }
  
  public int getWidth(){
    return rWidth;
  }
  
  public int getHeight(){
    return rHeight;
  }
}