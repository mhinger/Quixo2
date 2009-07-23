module PlayAgain
  
  def mouse_clicked(e)
    if production.timer_started == "Yes"
      production.animation.stop
    end
    scene.load("default_scene")
  end
  
end