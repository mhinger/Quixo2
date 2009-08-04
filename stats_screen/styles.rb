default_container {
  background_image "/Users/MHinger/Projects/quixo2/wood.jpg"
  width "100%"
  height "100%"
  horizontal_alignment :center
  vertical_alignment :center
}

game_name {
  float :on
  x 350
  y 100
  font_size 78
  text_color :black
  font_face :didot
  width 300
  horizontal_alignment :center
}

stats_container{
  width 500
  height 400
  horizontal_alignment :center
}

win_message {
  float :on
  # x 150
  y 50
  font_size 28
  text_color :black
  font_face :didot
  width "100%"
  horizontal_alignment :center
}

time {
  float :on
  x 73
  y 130
  font_size 28
  text_color :black
  font_face :didot
  width 350
  horizontal_alignment :center
}

turns {
  float :on
  x 73
  y 85
  font_size 22
  text_color :black
  font_face :didot
  width 350
  horizontal_alignment :center 
}

play_again {
  background_color :cornflower_blue
  secondary_background_color :royal_blue#:dodger_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 455
  y 390
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
  secondary_background_color :royal_blue#:dodger_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 455
  y 420
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }
}