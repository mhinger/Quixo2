# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

default_scene {
  background_color :red
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  height "100%"
  gradient :on
  gradient_angle 180
  gradient_penetration 100
  secondary_background_color :teal
  padding 90
}

board {
  width "94%"
  height "100%"
  background_color :black
  rounded_corner_radius 280
  top_padding 110
  left_padding 115
  right_padding 60
  bottom_padding 100
}

pieces {
  width 70
  height 70
  margin 2
  font_size 40
  vertical_alignment :center
  horizontal_alignment :center
}



