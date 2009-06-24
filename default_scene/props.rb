# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

#root :text => "This is the Default Scene scene."

board :id => "board", :text => "QUIXO"
side_bar {
  game_name :text => "QUIXO"
  small_buffer
  player :id => "player1", :text => "" 
  mark :id => "mark1", :text => "X"
  small_buffer
  player :id => "player2", :text => "" 
  mark :id => "mark2", :text => "O"
  buffer
  turn :id => "turn_bar", :text => "It's Now X's Turn"
  status :id => "status_bar", :text => ""
  buffer 
  timer :id => "timer", :text => "00:00"
}