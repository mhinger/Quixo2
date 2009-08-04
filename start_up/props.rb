default_container {
  buffer
  game_name :text => "QUIXO"  
  main_container {
    input_container {
      player_label :id => "p1", :text => "Player 1 Name: ", :players => "player_type"
      input :id => "player1", :players => 'text_box', :width => 130#, :text => "Matt"
    }
    buffer2
    check_box_label :id => "human_label", :text => "Human Opponenet? ", :left_padding => 376
    unchecked :id => 'unchecked', :players => "human_opponent", :float => 'on', :x => 532, :y => 46
    checked :id => 'checked', :players => "human_opponent", :float => 'on', :x => 532, :y => 44
    buffer6
    input_container {
      player_label :id => "p2", :text => "Player 2 Name: ", :players => "player_type", :transparency => 100
      input :id => "player2", :players => 'text_box', :width => 130, :transparency => 100#, :text => "John"
    }
    buffer2 
    check_box_label :id => "check_box", :text => "Speed Game? ", :left_padding => 376
    unchecked :id => 'unchecked_timer', :players => "timer_check", :float => 'on', :x => 487, :y => 118
    checked :id => 'checked_timer', :players => "timer_check", :float => 'on', :x => 487, :y => 116    
    buffer6
    timer_input_container {
      time_label :id => "time_label", :text => "Length of Game: (In Minutes)"
      input :id => "game_length", :players => 'text_box', :text => "1", :width => 60, :transparency => 100
    }
    # buffer2
    # buffer3    
    buffer4
    help :id => 'help', :text => 'Instructions', :on_mouse_clicked => "scene.load('instructions')"
    instrs :id => 'instrs', :text => 'Start Playing', :players => "instrs"
    
  }
}