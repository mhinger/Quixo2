default_container {
  buffer
  game_name :text => "QUIXO" 
  main_container {
    input_container {
      player_label :id => "p1", :text => "Player 1 Name: ", :players => "player_type"
      input :id => "player1", :players => 'text_box', :width => 130
    }
    buffer2
    check_box_label :id => "opponent_type", :text => "Opponent: ", :float => 'on', :x => 84, :y => 36
    check_box_label :id => "human", :text => "Human ", :float => 'on', :x => 174, :y => 36
    check_box_label :id => "ai", :text => "AI ", :float => 'on', :x => 274, :y => 36
    unchecked :id => 'human_unchecked', :players => "human_opponent", :float => 'on', :x => 235, :y => 39
    checked :id => 'human_checked', :players => "human_opponent", :float => 'on', :x => 235, :y => 37, :width => 0
    unchecked :id => 'ai_unchecked', :players => "human_opponent", :float => 'on', :x => 300, :y => 39
    checked :id => 'ai_checked', :players => "human_opponent", :float => 'on', :x => 300, :y => 37, :width => 0
    buffer6
    input_container {
      player_label :id => "p2", :text => "Player 2 Name: ", :players => "player_type", :transparency => 100
      input :id => "player2", :players => 'text_box', :width => 130, :transparency => 100
    }
    ai_diff :id => "ai_diff", :text => "AI Difficulty", :float => 'on', :x => 154, :y => 63, :transparency => 100
    check_box_label :id => "easy", :text => "Easy", :float => 'on', :x => 84, :y => 87, :transparency => 100
    check_box_label :id => "hard", :text => "Hard", :float => 'on', :x => 164, :y => 87, :transparency => 100
    check_box_label :id => "unbeat", :text => "Unbeatable", :float => 'on', :x => 244, :y => 87, :transparency => 100
    unchecked :id => 'easy_unchecked', :players => "ai_set_diff", :float => 'on', :x => 124, :y => 89, :transparency => 100
    checked :id => 'easy_checked', :players => "ai_set_diff", :float => 'on', :x => 124, :y => 87, :transparency => 100, :width => 0 
    unchecked :id => 'hard_unchecked', :players => "ai_set_diff", :float => 'on', :x => 208, :y => 89, :transparency => 100
    checked :id => 'hard_checked', :players => "ai_set_diff", :float => 'on', :x => 208, :y => 87, :transparency => 100, :width => 0
    unchecked :id => 'unbeat_unchecked', :players => "ai_set_diff", :float => 'on', :x => 332, :y => 89, :transparency => 100
    checked :id => 'unbeat_checked', :players => "ai_set_diff", :float => 'on', :x => 332, :y => 87, :transparency => 100, :width => 0
    buffer3 
    check_box_label :id => "check_box", :text => "Speed Game? ", :left_padding => 85, :float => 'on', :y => 107, :transparency => 100  
    unchecked :id => 'unchecked_timer', :players => "timer_check", :float => 'on', :x => 195, :y => 109, :transparency => 100  
    checked :id => 'checked_timer', :players => "timer_check", :float => 'on', :x => 195, :y => 107, :transparency => 100    
    buffer3
    timer_input_container {
      time_label :id => "time_label", :text => "Length of Game: (In Minutes)"
      input :id => "game_length", :players => 'text_box', :text => "1", :width => 60, :transparency => 100
    }
    buffer4
    help :id => 'help', :text => 'Instructions', :on_mouse_clicked => "scene.load('instructions')"
    instrs :id => 'instrs', :text => 'Start Playing', :players => "instrs"
  }
}

