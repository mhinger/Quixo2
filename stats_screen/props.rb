default_container {
  game_name :text => "QUIXO"
  stats_container {
    win_message :id => 'win_msg', :text => ""
    time :id => 'time', :text => ""
    turns :id => 'turn', :text => ""
  }
  play_again :id => 'play_again', :text => 'Play Again?', :players => 'play_again'
  home :id => 'return', :text => 'Home', :players => 'home'
}