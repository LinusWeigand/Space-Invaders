import java.util.Random;

public class DefenseBlock extends GameObject{
  private boolean[][] block;
  
  public DefenseBlock(int x, int y, int w, int h){
    super(x, y,w, h);
    block = new boolean[w][h];
    for(int i = 0; i < w; i++){
      for(int l = 0; l < h; l++){
        block[i][l] = true;
      }
    }
  }
  
  public void draw(){
    fill(255, 0, 0);
    for(int i = 0; i < block.length; i++){
      for(int l = 0; l < block[i].length; l++){
        if(block[i][l]){
          rect(rect.getLeft() + i, rect.getTop() + l, 1, 1);//zeichne einen Pixel
        }
      }
    }
  }
  
  public void collideWithShip(AlienShip s){
    Rectangle r = s.getRectangle();
    
    if(rect.intersects(r)){
      int baseX = rect.getLeft();
      int baseY = rect.getTop();
      for(int i = 0; i < rect.getWidth(); i++){
        for(int l = 0; l < rect.getHeight(); l++){
          if(block[i][l] && (baseX + i) >= r.getLeft() && (baseX + i + 1) <= (r.getLeft() + r.getWidth())
              && (baseY + l) >= r.getTop() && (baseY + l + 1) <= (r.getTop() + r.getHeight())){
            //falls kleiner Block innerhalb der Alienraumschiff-Hitbox
            block[i][l] = false;
              
           }
        }
      }    
    }
  
  }
  
  
  public void collideWithShot(Shot s){
    //pruefe erst, ob der Schuss im Bereich des grossen Blocks befindet
    //pruefe, ob der Schuss mit einem kleinem Block kollidiert
    //zerstoere zufaellig die kleinen Bloecke innerhalb eines Kreises
    
    Rectangle r = s.getRectangle();
    if(rect.intersects(r)){
      int x = rect.getLeft();
      int y = rect.getTop();
      boolean collideWithBlock = false;
      for(int i = 0; i < rect.getWidth(); i++){
        for(int l = 0; l < rect.getHeight(); l++){
          if(block[i][l] && (x + i) >= r.getLeft() && (x + i + 1) <= (r.getLeft() + r.getWidth())
              && (y + l) >= r.getTop() && (y + l+ 1) <= (r.getTop() + r.getHeight())){
            collideWithBlock = true;
            break;
          } 
        }//<---------fehlte
      }
      //falls 
      if(collideWithBlock){
        int mittelX = r.getLeft() + r.getWidth()/2;  //Mitte des Schuss
        int mittelY = r.getTop() + r.getHeight()/2;
        int radius = 10;
        for(int i = 0; i < rect.getWidth(); i++){
          for(int l = 0; l < rect.getHeight(); l++){
            int xDiff = (mittelX - (x + i));
            int yDiff = (mittelY - (y + l));
            //a^2 + b^2 = c^2
            if(xDiff * xDiff + yDiff * yDiff <= radius * radius && block[i][l]){
              //innerhalb des Kreises und Block existiert an dieser Stelle
              s.decreaseEnergy();
              if(Math.random() < 0.85)  block[i][l] = false;
            }
          }    
        }
      }    
    }
  }
}