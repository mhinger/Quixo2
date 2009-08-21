default_container {
  background_image "wood.jpg"  
  width "100%"
  height "100%"
  vertical_alignment :center
  horizontal_alignment :center
}

main_container {
  background_color "#D99963"#:tan
  width 800
  height 550
  rounded_corner_radius 20
  transparency 40
}

instrs {
  margin 25
  font_size 25
}

instrs2 {
  margin 25
  font_size 18
}

instrs3 {
  margin 25
  font_size 12
  float :on
  x 0
  y 490
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
  secondary_background_color :royal_blue
  gradient :on
  gradient_penetration 90
  width 90
  height 25
  float :on
  x 700
  y 510
  horizontal_alignment :center
  vertical_alignment :center
  rounded_corner_radius 12
  font_size 14
  font_face :didot
  hover {
    transparency 9
  }
}
