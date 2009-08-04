default_container {
  width "100%"
  height "100%"
  background_image "wood.jpg"
}

main_container {
  background_color :tan
  float :on
  x 270
  y 250
  width 470
  height 300
  rounded_corner_radius 20
  padding 25
}

buffer {
  width "100%"
  height "15%"
}

buffer2 {
  width "100%"
  height 20
}

buffer3 {
  height "100%"
  width "36.5%"
}

buffer4 {
  height "100%"
  width 20
}

buffer5 {
  width "100%"
  height 25
}

buffer6 {
  width "100%"
  height 10
}

game_name {
  width "100%"
  height "20%"
  font_size 78
  text_color :black
  font_face :didot
  horizontal_alignment :center
}

input_container {
  width "100%"
  horizontal_alignment :center
}

unchecked {
  background_image "open_check.png"
  width 14
  height 14
}

checked {
  background_image "check.png"
  width 15
  height 16
  transparency 100  
}

timer_input_container {
  left_padding 85
}

player_label {
  vertical_alignment :center
  width 120
  font_size 16
  text_color :black
  font_face :didot
}

time_label{
  vertical_alignment :center
  width 130
  font_size 16
  text_color :black
  font_face :didot 
  transparency 100 
}

button {
  width 125
  top_padding 7
}

check_box_label {
  font_size 16
  text_color :black
  font_face :didot  
}

help {
  background_color :cornflower_blue
  secondary_background_color :royal_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 240
  y 210
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }
}

instrs {
  background_color :cornflower_blue
  secondary_background_color :royal_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 100
  y 210
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }
}

