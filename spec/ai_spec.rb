require 'spec_helper'
require 'ai'
require 'game'

describe Ai do
  
  before(:each) do
    @comp = Ai.new
    @game = Game.new
  end
  
  it "should look one move ahead" do
    @comp.set_current_board(@game.board)
    @comp.print_board(@comp.current_board)
    @comp.look_ahead
  end
  
  
end




