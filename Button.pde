public class Button{
  private String text;
  private int x, y, w, h;//Dimension des Buttons
  private color orange, darkOrange, black, white;
  private boolean pressed = false;
  private ActionListener action;
  private boolean isVisible = true;
  
  
  public Button(String t){
    text = t;
    orange = color(255, 100, 0);
    darkOrange = color(180, 80, 0);//TODO Farben anschauen
    black = color(0, 0, 0);
    white = color(255, 255, 255);
    action = new ActionListenerA();
    //red = 255;
    //green = 100;
    //blue = 0;
    
  }
  
  public Button(String text, ActionListener action){
    this(text);//verwende anderen existierenden Konstruktor
    this.action = action;//setze neuen ActionListener
  }
  
  public void setBounds(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void draw(){
    //dunkel orange, wenn Maus im Buttonbereich und Maus gedrückt; ansonsten orange
    //weiss, wenn Maus im Buttonbereich; ansonsten schwarz
    /*
    orange = color(255, 100, 0);
    darkOrange = color(180, 80, 0);
    black = color(0, 0, 0);
    white = color(255, 255, 255);
    */
    if(isVisible){
      if(pressed && isInBounds()){
        fill(darkOrange);
      }else{
        fill(orange);
      }
      strokeWeight(3);//Randstaerke
      stroke(black);
      rect(x, y, w, h);
      if(isInBounds()){
        fill(white);
      }else{
        fill(black);
      }
      textSize(20);
      textAlign(CENTER, CENTER);
      text(text, x + w/2, y + h/2);
      }
    
  }
  
  public void mousePressed(){
    if(isInBounds()){
      pressed = true;
    }
  }
  public void mouseReleased(){
    if(isInBounds() && pressed && isVisible){
      //System.out.println(text);
      action.actionPerformed(this);
    }
    pressed = false;
  }
  private boolean isInBounds(){
    //linker Rand; rechter Rand; oberer Rand; unterer Rand
    return (x <= mouseX && x+w >= mouseX && y <= mouseY && y+h >= mouseY);
  }
  //Getter Methoden
  public String getText(){
    return text;
  }
  public int getX(){
    return x;
  }
  public int getY(){
    return y;
  }
  public int getWidth(){
    return w; 
  }
  public int getHeight(){
    return h;
  }
  //Setter Methoden
  public void setText(String t){
    text = t;
  }
  
  public void setVisible(boolean b){
    isVisible = b;
  }
}