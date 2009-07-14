default_container {
  buffer
  game_name :text => "QUIXO"  
  main_container {
    input_container {
      player_label :id => "p1", :text => "Player 1 Name: ", :players => "player_type"
      input :id => "player1", :players => 'text_box', :text => "Matt", :width => 130
    }
    buffer2
    check_box_label :id => "human_label", :text => "Human Opponenet? ", :left_padding => 376
    check_box :id => "Human Opponent?", :players => 'human_opponent', :float => 'on', :x => 530, :y => 41
    buffer6
    input_container {
      player_label :id => "p2", :text => "Player 2 Name: ", :players => "player_type", :transparency => 100
      input :id => "player2", :players => 'text_box', :text => "John", :width => 130, :transparency => 100
    }
    buffer2 
    check_box_label :id => "check_box", :text => "Speed Game? ", :left_padding => 376
    check_box :id => "timed?", :players => 'timer_check', :float => 'on', :x => 485, :y => 112
    buffer6
    timer_input_container {
      time_label :id => "time_label", :text => "Length of Game: (In Minutes)"
      input :id => "game_length", :players => 'text_box', :text => "1", :width => 60, :transparency => 100
    }
    buffer2
    buffer3
    button :id => 'begin_game', :players => "start_up", :text => 'Begin Game'
    buffer4
    button :id => 'help', :text => 'Instructions', :on_button_pressed => "scene.load('instructions')"
  }
}