# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

#root :text => "This is the Default Scene scene."

turn = 1
game_pieces = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]


board :id => "board", :turn => 1 do
  25.times do |i|
    pieces :id => i, :background_color => :tan, :text => "", :location => i
  end
end

next_turn
turn = turn + 1
#puts(turn)

