module Restart
  
  def button_pressed(event)
    production.animation.stop
    scene.load("default_scene")
  end
  
end