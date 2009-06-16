require "spec_helper"
require "game"
require "turn"

describe Turn, "changing_turn" do
  
  before(:all) do
    @turn = Turn.new
  end
  
  it "should change turns" do
    @turn.change_turn("O").should be_true
    puts "previous: #{@turn.prev_turn}"    
    puts "current: #{@turn.current_turn}"
  end
  
  it "should remember the most recent turns" do
    @turn.prev_turn.should == "X"
  end
  
  it "should remember the current turn" do
    @turn.current_turn.should == "O"    
  end
  
  it "should change turns again" do
    @turn.change_turn("X").should be_true
    puts "previous: #{@turn.prev_turn}"    
    puts "current: #{@turn.current_turn}"   
  end
  
  it "should remember prev again" do
    @turn.prev_turn.should == "O"
  end
  
  it "should remember current again" do
    @turn.current_turn.should == "X"
  end
  
end