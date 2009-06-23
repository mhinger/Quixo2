# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

default_scene {
  background_image "/Users/MHinger/Projects/quixo2/104.jpg"
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  height "100%"
}

board {
  width "80%"
  height "100%"
  background_color :black
  rounded_corner_radius 280
  top_margin 100
  bottom_margin 100
  right_margin 120
  left_margin 120
  top_padding 100
  left_padding 105
  right_padding 60
  bottom_padding 100
}

pieces {
  width 70
  height 70
  margin 2
  font_size 40
  background_color :tan#"#F1E4B7"
  text_color "#004358"
  font_style :italic
  vertical_alignment :center
  horizontal_alignment :center
}

side_bar {
  background_color :Fire_Brick #{}"#8EB7A8"
  width "20%"
  height "100%"
}



