module Back
  
  def button_pressed(event)
    production.animation.stop
    scene.load("start_up")
  end
  
end