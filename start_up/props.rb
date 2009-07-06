default_container {
  buffer
  game_name :text => "QUIXO"  
  main_container {
    input_container {
      player_label :id => "p1", :text => "Player 1 Name: ", :players => "player_type"#, :on_mouse_clicked => "puts 'I was clicked'"
      input :id => "player1", :players => 'text_box', :text => "Matt", :width => 130
    }
    buffer2
    input_container {
      player_label :id => "p2", :text => "Player 2 Name: ", :players => "player_type"#, :on_mouse_clicked => "scene.load('instructions')"
      input :id => "player2", :players => 'text_box', :text => "John", :width => 130
    }
    
    check_box_label :id => "check_box", :text => "Speed Game? "
    check_box :id => "timed?", :players => 'timer_check'
 
    buffer5
    
    input_container {
      time_label :id => "time_label", :text => "Length of Game: (In Minutes)"
      input :id => "game_length", :players => 'text_box', :text => "1", :width => 130, :transparency => 100
    }
    buffer2
    buffer3
    button :id => 'begin_game', :players => "start_up", :text => 'Begin Game'
    buffer4
    button :id => 'help', :text => 'Instructions', :on_button_pressed => "scene.load('instructions')"
  }
}