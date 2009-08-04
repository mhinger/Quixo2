module HumanOpponent
  
  attr_reader :checked
  
  def mouse_clicked(event)
    unchecked = scene.find('unchecked')
    checked = scene.find('checked')
    player_label = scene.find("p2")
    input = scene.find("player2")
    if checked.style.transparency == "100%"
      unchecked.style.transparency = 100
      checked.style.transparency = 0
      unchecked.style.width = 0
      unchecked.style.height = 0
      checked.style.width = 16
      checked.style.width = 15
      player_label.style.transparency = 0
      input.style.transparency = 0
      production.game_type = "Two Player Game"      
    elsif checked.style.transparency == "0%"
      unchecked.style.transparency = 0
      checked.style.transparency = 100
      unchecked.style.width = 14
      unchecked.style.height = 14
      checked.style.width = 0
      checked.style.width = 0
      player_label.style.transparency = 100
      input.style.transparency = 100
      production.game_type = "One Player Game"
    end
  end
  
end