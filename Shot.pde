public class Shot extends GameObject{
  private int ySpeed, energy;
 
  public Shot(int l, int t, int ySpeed){
    super(l, t, 5, 30);
    this.ySpeed = ySpeed;
    isAlive = true;
    energy = 200;
  }
  
  public void move(Rectangle bounds){
    if(isAlive){
      rect = rect.move(0, ySpeed);//bewege 
      if(!rect.intersects(bounds)){
        //Schuss ist ausserhalb des Bildschirms
        System.out.println("outOfBounds");
        isAlive = false;
      }
    }
  }
  
  public void draw(){
    if(isAlive){
      fill(0,255,0);
      noStroke();
      //In Klammern: Werte werden mit getter Methoden angefordert
      //rect(): Methode, die Rechtecke zeichnet
      rect(rect.getLeft(), rect.getTop(), rect.getWidth(), rect.getHeight());
    }
   }
   
   public void decreaseEnergy(){
     energy--;
     if(energy == 0){
       setAlive(false);
     }
   }  
}