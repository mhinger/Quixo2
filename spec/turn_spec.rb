require "spec_helper"
require "game"
require "turn"

describe Turn, "Changing Turns" do
  
  before(:all) do
    @turn = Turn.new
  end
  
  it "should remember the previous turn" do
    @turn.prev_turn.should == "O"
  end
 
  it "should recognize the current turn" do
    @turn.current_turn.should == "X"
    puts @turn.current_turn
  end 

  it "should change turns" do
    @turn.change_turn("O").should be_true
  end

  it "should recognize the current turn" do
    @turn.current_turn.should == "O"
    puts @turn.current_turn
  end  
  
  it "should change turns" do
    @turn.change_turn("X").should be_true
    @turn.change_turn("O")
  end
  
end