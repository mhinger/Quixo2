default_container {
  background_image "/Users/MHinger/Projects/quixo2/wood.jpg"  
  width "100%"
  height "100%"
  vertical_alignment :center
  horizontal_alignment :center
}

main_container {
  background_color :tan
  width 800
  height 490
  rounded_corner_radius 20
}

instrs {
  margin 25
  font_size 25
}

instrs2 {
  margin 25
  font_size 18
}

buffer2 {
  height 100
  width 680
}

button {
  margin 4
}

back {
  background_color :cornflower_blue
  secondary_background_color :royal_blue#:dodger_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 700
  y 450
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }
}
