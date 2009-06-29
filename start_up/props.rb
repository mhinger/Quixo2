default_container {
  buffer
  game_name :text => "QUIXO"
  main_container {
    input_container {
      label :text => "Player 1 Name: ", :players => "player_type"
      input :id => "player1", :players => 'text_box', :width => 130
    }
    buffer2
    input_container {
      label :text => "Player 2 Name: ", :players => "player_type"
      input :id => "player2", :players => 'text_box', :width => 130
    }
    buffer2
    buffer3
    button :id => 'begin_game', :players => 'start_up', :text => 'Begin Game'
    buffer4
    button :id => 'help', :players => 'instructions', :text => 'Instructions'
  }
}