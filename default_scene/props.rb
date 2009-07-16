# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

#root :text => "This is the Default Scene scene."

board :id => "board"
side_bar {
  game_name :text => "QUIXO"
  small_buffer
  player :id => "p1", :text => ""
  mark :id => "mark1", :text => "X"
  small_buffer
  player :id => "p2", :text => "" 
  mark :id => "mark2", :text => "O"
  buffer
  turn :id => "turn_bar", :text => ""
  status :id => "status_bar", :text => ""
  buffer2
  timer :id => 'player1_timer', :text => "00:00"
  timer :id => 'player2_timer', :text => "00:00"
  button :id => 'restart', :text => 'Restart', :players => 'restart'
  button :id => 'return', :text => 'Home', :players => 'back'
}
