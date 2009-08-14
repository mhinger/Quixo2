# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL
whole_scene {  
  board :id => "board" do
    25.times do |i|
      pieces :id => i
    end
  end
  side_bar {
    game_name :text => "QUIXO"
    small_buffer
    player :id => "p1", :text => ""
    mark :id => "mark1", :text => "X"
    small_buffer
    player :id => "p2", :text => "" 
    mark :id => "mark2", :text => "O"
    turn :id => "turn_bar", :text => ""
    status :id => "status_bar", :text => ""
    timer :id => 'player1_timer', :text => "00:00", :y => 500
    timer :id => 'player2_timer', :text => "00:00", :y => 540
    restart :id => 'restart', :text => 'Restart', :players => 'restart'
    home :id => 'return', :text => 'Home', :players => 'back'
  }
  strike_through :id => "strike_through", :players => "image", :image => "rectangle.jpg", :transparency => 0, :scaled => false, :rotation => 45, :width => 0, :height => 0
  ran_out_time :id => "no_time", :width => 0, :height => 0
  stats :id => 'stats', :players => 'stats', :text => 'Game Stats', :width => 0, :height => 0
}