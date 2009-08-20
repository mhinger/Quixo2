default_scene {
  background_image "wood.jpg"
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  height "100%"
}

board {
  width "80%"
  height "100%"
  background_color "#5E0900"
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
  margin 1
  font_size 40
  # background_color "#D99963" #:tan #9E6835
  # background_image_fill_strategy :static
  # text_color "#004358"
  # font_style :italic
  font_face :didot
  vertical_alignment :center
  horizontal_alignment :center
  hover {
    background_color "#F1E4B7"
  }
}

side_bar {
  background_color :Fire_Brick
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

board_name {
  width 80
  height 25
  font_size 20
  font_face :didot
  float :on
  x 365
  y 610
  text_color :white
}

square {
  background_color :black
}

small_buffer {
  width "100%"
  height 50
}

smaller_buffer {
  width "100%"
  height 40
}

player {
  background_color :tan
  width "70%"
  vertical_alignment :center
  font_size 18
  font_face :didot  
  left_padding 20
  rounded_corner_radius 10
}

mark {
  width "30%"
  vertical_alignment :center
  horizontal_alignment :center
  font_size 18
  font_face :didot
}

buffer {
  width "100%"
  height 130
}

buffer2 {
  width "100%"
  height 40
}

turn {
  background_color :tan
  vertical_alignment :center
  horizontal_alignment :center  
  font_size 18
  font_face :didot
  float :on
  y 330
  width "100%"
  height 60
  bottom_margin 5
  rounded_corner_radius 10
}

timer {
  background_color :tan
  vertical_alignment :center
  horizontal_alignment :center  
  float :on
  font_size 18
  font_face :didot
  width "100%"
  height 40
  top_margin 5
  bottom_margin 5
  rounded_corner_radius 10
}

status {
  background_color :tan
  vertical_alignment :center
  horizontal_alignment :center  
  font_size 18
  font_face :didot
  float :on
  y 400
  width "100%"
  height 60
  top_margin 5
  bottom_margin 5
  padding 5
  rounded_corner_radius 10
}

button {
  top_padding 7
  width "100%"
}

strike_through {
  float :on
  x 223 
  y 198 
}

ran_out_time {
  float :on
  x 223
  y 198
}

restart {
  background_color :cornflower_blue
  secondary_background_color :royal_blue#:dodger_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 45
  y 620
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }  
}

home {
  background_color :cornflower_blue
  secondary_background_color :royal_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 45
  y 650
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }  
}

stats {
  background_color :cornflower_blue
  secondary_background_color :royal_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 355
  y 570
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }
}