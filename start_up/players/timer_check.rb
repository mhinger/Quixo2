module TimerCheck
  
  def button_pressed(e)
    timer_box = scene.find('timed?')
    time_label = scene.find('time_label')
    game_length = scene.find('game_length')
    if timer_box.checked? == true
      time_label.style.transparency = 0
      game_length.style.transparency = 0
      production.timed_game = "Yes"
    elsif timer_box.checked? == false
      time_label.style.transparency = 100
      game_length.style.transparency = 100
      production.timed_game = "No"
    end
  end
  
end