module Back
  
  def mouse_clicked(event)
    if production.timer_started == "Yes"
      production.animation.stop
    end
    scene.load("start_up")
  end
  
end