module Help
  
  def mouse_clicked(event)
    if production.timer_started == "Yes"
      production.animation.stop
    end
    scene.load("Instructions")
  end
  
end