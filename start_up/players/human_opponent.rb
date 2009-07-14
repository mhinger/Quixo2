module HumanOpponent
  
  def button_pressed(e)
    human_box = scene.find('Human Opponent?')
    player_label = scene.find("p2")
    input = scene.find("player2")
    if human_box.checked? == true
      player_label.style.transparency = 0
      input.style.transparency = 0
      production.game_type = "Two Player Game"
    elsif human_box.checked? == false  
      player_label.style.transparency = 100
      input.style.transparency = 100
      production.game_type = "One Player Game"
    end
  end
  
end