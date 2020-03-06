public class RestartActionListener implements ActionListener{
  private Main game;
  
  public RestartActionListener(Main g){
    game = g;
  }
  
  public void actionPerformed(Button b){
    game.initGame();
    System.out.println("new game");
  }
}

public class ActionListenerA implements ActionListener{
  public void actionPerformed(Button b){
    System.out.println(b.getText());
  }
}