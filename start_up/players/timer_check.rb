module TimerCheck
  
  def mouse_clicked(e)
    unchecked = scene.find('unchecked_timer')
    checked = scene.find('checked_timer')
    time_label = scene.find('time_label')
    game_length = scene.find('game_length')
    if checked.style.transparency == "100%"
      unchecked.style.transparency = 100
      checked.style.transparency = 0
      unchecked.style.width = 0
      unchecked.style.height = 0
      checked.style.width = 16
      checked.style.width = 15
      time_label.style.transparency = 0
      game_length.style.transparency = 0
      game_length.style.width = 60
      production.timed_game = "Yes"
    elsif checked.style.transparency == "0%"
      unchecked.style.transparency = 0
      checked.style.transparency = 100
      unchecked.style.width = 14
      unchecked.style.height = 14
      checked.style.width = 0
      checked.style.width = 0
      time_label.style.transparency = 100
      game_length.style.transparency = 100
      game_length.style.width = 0
      production.timed_game = "No"
    end
  end
  
end