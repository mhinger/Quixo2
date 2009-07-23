module Back
  
  def mouse_clicked(event)
    if production.timer_started == "Yes"
      production.animation.stop
    end
    production.timed_game = "No"
    production.game_type = "One Player Game"
    scene.load("start_up")
  end
  
end