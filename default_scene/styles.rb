# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

default_scene {
  background_image "/Users/MHinger/Projects/quixo2/wood.jpg"
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
  hover {
    background_color "#F1E4B7"
  }
}

side_bar {
  background_color :Fire_Brick #"#8EB7A8"
  width "20%"
  height "100%"
  top_padding 40
  left_padding 10
  right_padding 10
}

game_name {
  vertical_alignment :center
  horizontal_alignment :center
  font_size 46
  font_face :didot
  width "100%"
  height 60
  margin 5
}

small_buffer {
  width "100%"
  height 50
}

player {
  background_color :tan
  width "70%"
  height 24
  vertical_alignment :center
  font_size 18
  font_face :didot  
  left_padding 20
}

mark {
  background_color :tan
  width "30%"
  height 24
  vertical_alignment :center
  horizontal_alignment :center
  font_size 16
  font_face :didot
}


buffer {
  width "100%"
  height 150
}

turn {
  background_color :tan
  vertical_alignment :center
  horizontal_alignment :center  
  font_size 18
  font_face :didot
  width "100%"
  height 40
  margin 5
}

timer {
  background_color :tan
  vertical_alignment :center
  horizontal_alignment :center  
  font_size 18
  font_face :didot
  width "100%"
  height 40
  margin 5 
}

status {
  background_color :tan
  vertical_alignment :center
  horizontal_alignment :center  
  font_size 18
  font_face :didot
  width "100%"
  height 40
  margin 5  
}