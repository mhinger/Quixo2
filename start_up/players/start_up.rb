module StartUp
  prop_reader :player1
  prop_reader :player2
  prop_reader :game_length
  
  def button_pressed(event)
    text1 = player1.text
    production.player1 = text1
    text2 = player2.text
    production.player2 = text2
    length = game_length.text 
    production.game_length_min = length.to_i
    production.timer_started = "No"
    if production.timed_game != "Yes"
      production.timed_game = "No"
    end
    scene.load("default_scene")
  end
  
end