import java.util.Random; 




/**
Kolissionen
Schuss - Raumschiff
Schuss - Hindernis <- Flaechenkolission
Schuss - Schuss
Raumschiff - Hindernis

TODO:
- Schussfarben
- Raumschifftexturen
- Flaechenschaden (schuss)
- Konstanten oben definieren

Bugs:
- rTop + rHeight < rect.rTop (in Rectangle)

*/
//draw aliens
private int alienSpeed = 5;
private final int PLAYER_SHOT_SPEED = -15;
private final int ALIEN_SHOT_SPEED = 5;

private AlienShip[][] aliens;
private PlayerShip ship;
private boolean leftPressed, rightPressed, shoot;
private Shot playerShot;
private Rectangle bounds = new Rectangle(0,0,600, 650);//Fenstergroesse

private int direction; //Bewegungsrichtung der Aliens
private int[] curShip; //Aktuelles Alienraumschiff, dass bewegt werden soll
public final int DIR_L = 0;
public final int DIR_D1 = 1;
public final int DIR_R = 2;
public final int DIR_D2 = 3;
//L -> Down1 -> R -> Down2 -> L
//Schuesse Aliens
private ArrayList<Shot> alienShots;
private DefenseBlock[] arrBlocks;

private int level;
private int Leben;

private int aliensAlive;
private int TransitionState;
private int Transition = 0;
PImage img;

void setup(){
 size(600, 650);
      initGame();
    }
  void initGame(){
    Leben = 3;
    initLevel(1);
  }
  
  void initLevel(int currentLevel){
    level = currentLevel;
    aliensAlive = 55;
    
     
  ship = new PlayerShip(270, 620, 60, 20);
  playerShot = new Shot(0,0, PLAYER_SHOT_SPEED);
  playerShot.setAlive(false);
  aliens = new AlienShip[11][5];
  curShip = new int[]{0,0};
  for(int i = 0; i < aliens.length; i++){
    for(int l = 0; l < aliens[i].length; l++){
      aliens[i][l] = new AlienShip(30 + i * 50, 350 - l * 50, 40, 30);
    }
  }
  
    
    
  alienShots = new ArrayList<Shot>();
  level = 5;
  arrBlocks = new DefenseBlock[4];
  arrBlocks[0] = new DefenseBlock(40, 500, 70, 70);
  arrBlocks[1] = new DefenseBlock(40 + 150, 500, 70, 70);
  arrBlocks[2] = new DefenseBlock(40 +300, 500, 70, 70);
  arrBlocks[3] = new DefenseBlock(40 + 450, 500, 70, 70);
}

void updateGame(){
  
  playerShot.move(bounds);
  
  for(Shot s: alienShots){
    s.move(bounds);
  }
  
  //Schiffsbewegung
  if(leftPressed){
    ship.moveLeft();
  }
  if(rightPressed){
    ship.moveRight();
  }
  //Alienbewegung
  int x = 0;
  while(x < 1){
    if(aliens[curShip[0]][curShip[1]].isAlive()) x++;
      if (direction == DIR_L){
        aliens[curShip[0]][curShip[1]].move(-alienSpeed, 0);//Schiff bewegen
        curShip = next(curShip);//naechstes Schiff waehlen
        if(isFirst(curShip) && !canMoveLeft()){
          direction = DIR_D1;  
        } 
    }else if(direction == DIR_D1 || direction == DIR_D2){
      aliens[curShip[0]][curShip[1]].move(0, 15);
      curShip = next(curShip);
      if(isFirst(curShip)){
        direction = (direction == DIR_D1)?DIR_R: DIR_L;
      }  
    }else if (direction == DIR_R){
        aliens[curShip[0]][curShip[1]].move(+alienSpeed, 0);//Schiff bewegen
        curShip = next(curShip);
        if(isFirst(curShip) && !canMoveRight()){
          direction = DIR_D2;  
        } 
    }
  }
  
  
  
  //Kolissionen -------------------
  //Explosion Schiff - Spielerschuss
  //Schiff Schuss
  for(int i = 0; i < aliens.length; i++){
    for(int l = 0; l < aliens[i].length; l++){
      if(aliens[i][l].isAlive() && playerShot.isAlive() && playerShot.getRectangle().intersects(aliens[i][l].getRectangle())){
        playerShot.setAlive(false);
        aliens[i][l].setAlive(false);
        aliensAlive--;
        //aliensAlive--;
      }
    }
  }
  
  //Kollision AlienSchuss - Spieler
  
   for(Shot s: alienShots){
     
     if(s.getRectangle().intersects(ship.getRectangle()) && s.isAlive()){
        background(0,0,0,Transition);
       s.setAlive(false);
       if(!ship.isProtected()){
         ship.activateHit();
         Leben--;
       }
     
       
      
      
    }
    
  }
  
  //Kollision Block - Schuss
  for(int i = 0; i < arrBlocks.length; i++){
    for(Shot s:alienShots){
      arrBlocks[i].collideWithShot(s);
    }    
    arrBlocks[i].collideWithShot(playerShot);
    
    
    //Kollision Block - Schiff
    for(int m = 0; m< aliens.length; m++){
      for(int n = 0; n< aliens[m].length; n++){
        if(aliens[m][n].isAlive()){
          arrBlocks[i].collideWithShip(aliens[m][n]);
        }
      }
    }    
  }    
  
  //neue Alienschuesse erstellen
  cleanUpList();
  if(alienShots.size() < level){
    if(Math.random() < 0.1){
      Random ra = new Random();
      int column = ra.nextInt(aliens.length);
      for(int l = 0; l < aliens[column].length; l++){
        if(aliens[column][l].isAlive()){
          Rectangle r = aliens[column][l].getRectangle();
          alienShots.add(new Shot(-3 + r.getLeft() + r.getWidth()/2, r.getTop() + r.getHeight(), ALIEN_SHOT_SPEED));//Schuss mittig unterhalb des Alienraumschiff abfeuern
          break;
          //...
          //return;
        }
      }
      
    }
  }
  
  
  
  
  
  //Neuen Schuss starten
  if(playerShot.isAlive() == false && shoot == true){
      //Schuss neu positionieren
      Rectangle r = ship.getRectangle();
      playerShot = new Shot(r.getLeft() + r.getWidth()/2 - 3, r.getTop() - 30, PLAYER_SHOT_SPEED);
  
  }
  //int a = (aliensAlive>0)? 0 : 1;
  if(aliensAlive == 0){
    initLevel(level + 1);
  }
}
void draw(){
  if (Leben > 0){
  updateGame();
  }
  if(Leben > 0){
    
    
    
  
  
  //Zeichnung
  


  background(0);//neue Zeichnung beginnen
  textSize(30);
  fill(42,90,216);
  text("Leben: " + Leben  , 470 , 45);
  ship.draw();  
  for(int i = 0; i < aliens.length; i++){
    for(int l = 0; l < aliens[i].length; l++){
      aliens[i][l].draw();
    }
  }
  playerShot.draw();
  for(Shot s: alienShots){
    s.draw();
  }
  
  for(int i = 0; i < arrBlocks.length; i++){
    arrBlocks[i].draw();
  }    

}else{
  
  if(TransitionState > -1){
    TransitionState++;
     if ((TransitionState/20)% 2 == 0){
      Transition++;
 background(0,0,0,Transition);
    }
  }
  
 
  fill(42,90,216);
  text("Leben: 0"  , 470 , 45);
  
  text("Game over",200,300);
  
  
}
}
void keyPressed(){
  if(keyCode == 37){
    //linke Pfeiltaste
    leftPressed = true;
  }else if(keyCode == 39){
    //rechte Pfeiltaste
    rightPressed = true;
  }else if(keyCode == 32){
    shoot = true;
  }
}

void keyReleased(){
  if(keyCode == 37){
    //linke Pfeiltaste
    leftPressed = false;
  }else if(keyCode == 39){
    //rechte Pfeiltaste
    rightPressed = false;
  }else if(keyCode == 32){
    shoot = false;
  }
}

boolean canMoveLeft(){
  //kann sich die Raumschiffgruppe noch nach links bewegen?
  for(int i = 0; i < aliens.length; i++){
    for(int l = 0; l < aliens[i].length; l++){
      if(aliens[i][l].isAlive()){
        //dieses Schiff ist ganz links
        return aliens[i][l].getRectangle().getLeft() >= alienSpeed;//falls eine Bewegung noch moeglich
      }  
    }
  }
  return false;
}

boolean canMoveRight(){
  //kann sich die Raumschiffgruppe noch nach rechts bewegen?
  //Schleife beginnt bei der Spalte ganz rechts und geht dann nach links
  for(int i = aliens.length - 1; i >= 0; i--){
    for(int l = 0; l < aliens[i].length; l++){
      if(aliens[i][l].isAlive()){
        //dieses Schiff ist ganz rechts
        return (aliens[i][l].getRectangle().getLeft() + aliens[i][l].getRectangle().getWidth()) <= width - alienSpeed;//falls eine Bewegung noch moeglich
      }  
    }
  }
  return false;
}

public int[] next(int[] cur){
  if(cur[0] == aliens.length - 1){
    //Falls Schiff ganz rechts einer Zeile
    if (cur[1] == aliens[0].length - 1){
      //falls schiff oben rechts, dann beginne von vorne
      return new int[]{0, 0};
    }
    //gehe eine Zeile hoch
    return new int[]{0, cur[1] + 1};
  }else{
    return new int[]{cur[0]  +1, cur[1]};//waehle schiff eine Position weiter rechts
  }
}

public boolean isFirst(int[] cur){
  return  cur[0] == 0 && cur[1] == 0;//Schiff unten links?
}

public void cleanUpList(){
  ArrayList<Shot> toRemove = new ArrayList<Shot>();
  for(Shot s: alienShots){
    if (!s.isAlive()) toRemove.add(s);
  }
  for(Shot s: toRemove){
    alienShots.remove(s);
  }
}