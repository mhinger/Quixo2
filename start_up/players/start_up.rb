module StartUp
  prop_reader :player1
  prop_reader :player2
  
  def button_pressed(event)
     # scene.production.game.player1 = player1.text
    # scene.production.game.player2 = player2.text
    scene.load("default_scene")
  end
  
end