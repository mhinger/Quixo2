# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

#root :text => "This is the Default Scene scene."

board :id => "board", :text => "QUIXO"
side_bar {
  game_name :text => "QUIXO"
  small_buffer
  player :id => "player1", :text => "Player 1     X"
  small_buffer
  player :id => "player2", :text => "Player 2     O"
  playe
  buffer
  turn :text => "Its X's Turn"
  status :text => "Status Bar"
  buffer 
  timer :text => "00:00"
}