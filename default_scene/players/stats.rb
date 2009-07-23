module Stats
  
  def mouse_clicked(event)
    if production.timer_started == "Yes"
      production.animation.stop
    end
    scene.load("stats_screen")
  end
  
end