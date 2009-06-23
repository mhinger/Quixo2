require 'spec_helper'
require "game"

describe Game do
  
  before(:each) do
    @game = Game.new
  end
  
  it "should have board array" do
    @game.board.should == [] 
  end
  
  it "should have no victories" do
    @game.victory?("X").should be_false
  end

  it "should have a simple win " do
    @game.board[0] = "X"
    @game.board[1] = "X"
    @game.board[2] = "X"
    @game.board[3] = "X"
    @game.board[4] = "X"
    
    @game.victory?("X").should be_true
  end
    
  it "should test that victories are continuous" do
    @game.board[0] = "X"
    @game.board[1] = "O"
    @game.board[2] = "X"
    @game.board[3] = "X"
    @game.board[4] = "X"
    
    @game.victory?("X").should be_false
  end
  
  it "have a victory on the second row" do
    @game.board[5] = "X"
    @game.board[6] = "X"
    @game.board[7] = "X"
    @game.board[8] = "X"
    @game.board[9] = "X"
    
    @game.victory?("X").should be_true    
  end
  
  it "have a victory on the third row" do
    @game.board[10] = "X"
    @game.board[11] = "X"
    @game.board[12] = "X"
    @game.board[13] = "X"
    @game.board[14] = "X"
    
    @game.victory?("X").should be_true    
  end
    
  it "have a victory on the fourth row" do
    @game.board[15] = "X"
    @game.board[16] = "X"
    @game.board[17] = "X"
    @game.board[18] = "X"
    @game.board[19] = "X"
    
    @game.victory?("X").should be_true    
  end  
  
  it "have a victory on the fifth row" do
    @game.board[20] = "X"
    @game.board[21] = "X"
    @game.board[22] = "X"
    @game.board[23] = "X"
    @game.board[24] = "X"
    
    @game.victory?("X").should be_true    
  end  
  
  it "should not consider wrap arounds as a victory" do
    @game.board[3] = "X"
    @game.board[4] = "X"
    @game.board[5] = "X"
    @game.board[6] = "X"
    @game.board[7] = "X"
    
    @game.victory?("X").should be_false
  end
  
  it "should have a simple vertical victory" do
    @game.board[0] = "X"
    @game.board[5] = "X"
    @game.board[10] = "X"
    @game.board[15] = "X"
    @game.board[20] = "X"

    @game.victory?("X").should be_true
  end
    
  it "should have victory in the second column" do
    @game.board[1] = "X"
    @game.board[6] = "X"
    @game.board[11] = "X"
    @game.board[16] = "X"
    @game.board[21] = "X"

    @game.victory?("X").should be_true
 end  

 it "should have victory in the third column" do
     @game.board[2] = "X"
     @game.board[7] = "X"
     @game.board[12] = "X"
     @game.board[17] = "X"
     @game.board[22] = "X"

     @game.victory?("X").should be_true
  end  
  
  it "should have victory in the fourth column" do
    @game.board[3] = "X"
    @game.board[8] = "X"
    @game.board[13] = "X"
    @game.board[18] = "X"
    @game.board[23] = "X"

    @game.victory?("X").should be_true
 end

 it "should have victory in the fourth column" do
   @game.board[4] = "X"
   @game.board[9] = "X"
   @game.board[14] = "X"
   @game.board[19] = "X"
   @game.board[24] = "X"

   @game.victory?("X").should be_true
  end   
  
  it "should have a diagonal victory l-r" do
    @game.board[0] = "X"
    @game.board[6] = "X"
    @game.board[12] = "X"
    @game.board[18] = "X"
    @game.board[24] = "X"

    @game.victory?("X").should be_true
  end 

  it "should not wrap diagonal victories" do
    @game.board[1] = "X"
    @game.board[7] = "X"
    @game.board[13] = "X"
    @game.board[19] = "X"
    @game.board[21] = "X"

    @game.victory?("X").should be_false
  end   
  
  it "diagonal victories should be conitinuous" do
    @game.board[0] = "X"
    @game.board[6] = "X"
    @game.board[12] = "O"
    @game.board[18] = "X"
    @game.board[24] = "X"

    @game.victory?("X").should be_false
  end    
  
  it "should have diagonal victories r-l" do
    @game.board[4] = "X"
    @game.board[8] = "X"
    @game.board[12] = "X"
    @game.board[16] = "X"
    @game.board[20] = "X"

    @game.victory?("X").should be_true       
  end 
  
  it "should be a victory" do
    @game.board[0] = "X"
    @game.board[4] = "X"
    @game.board[8] = "X"
    @game.board[10] = "X"
    @game.board[12] = "X"
    @game.board[16] = "X"
    @game.board[19] = "X"
    @game.board[20] = "X"
    @game.board[22] = "X"
    @game.board[20] = "X"
    
    @game.victory?("X").should be_true
  end
  
  it "should be a victory2" do
    @game.board[2] = "X"
    @game.board[4] = "O"
    @game.board[7] = "X"
    @game.board[8] = "O"
    @game.board[12] = "X"
    @game.board[16] = "O"
    @game.board[17] = "O"
    @game.board[20] = "X"
    @game.board[21] = "X"
    @game.board[22] = "X"
    @game.board[23] = "X"
    @game.board[24] = "X"
    
    @game.victory?("X").should be_true
  end    
  
  it "should check for an os victory" do
    @game.board[2] = "X"
    @game.board[4] = "O"
    @game.board[7] = "X"
    @game.board[8] = "O"
    @game.board[12] = "O"
    @game.board[16] = "O"
    @game.board[17] = "O"
    @game.board[20] = "O"
    @game.board[21] = "X"
    @game.board[22] = "X"
    @game.board[23] = "X"
    @game.board[24] = "X"     
        
    @game.victory?("O").should be_true
  end
    
  it "should not be a victory" do
    @game.board[0] = "O"
    @game.board[6] = "O"
    @game.board[12] = "O"
    @game.board[18] = "O"
    @game.board[24] = "X"   
    
    @game.victory?("O").should be_false 
  end  
  
  it "should not be a victory" do
    @game.board[4] = "X"
    @game.board[0] = "O"
    @game.board[21] = "X"
    @game.board[22] = "X"
    @game.board[23] = "X"
    @game.board[24] = "O"
    @game.board[14] = "X"
    @game.board[19] = "O" 
    
    @game.victory?("O").should be_false 
  end
  
  # it "should have basic vertical shifts of the board" do
  #    @game.board[0] = "X "
  #    @game.board[1] = "1 "
  #    @game.board[2] = "2 "
  #    @game.board[3] = "3 "
  #    @game.board[4] = "4 "
  #    @game.board[5] = "O "  
  #    @game.board[6] = "6 "
  #    @game.board[7] = "X "
  #    @game.board[8] = "8 "
  #    @game.board[9] = "9 "     
  #    @game.board[10] = "X "
  #    @game.board[11] = "11 "    
  #    @game.board[12] = "O "
  #    @game.board[13] = "13 "
  #    @game.board[14] = "14 "
  #    @game.board[15] = "15 "
  #    @game.board[16] = "16 "
  #    @game.board[17] = "O "
  #    @game.board[18] = "18 "
  #    @game.board[19] = "19 "
  #    @game.board[20] = "20 "
  #    @game.board[21] = "21 "
  #    @game.board[22] = "X "
  #    @game.board[23] = "23 "
  #    @game.board[24] = "24 "
  #    @game.shift_board(22,2,"X ").should be_true
  #  end

  # it "should have basic horizontal shifts of the board" do
  #   @game.board[0] = "X "
  #   @game.board[1] = "O "
  #   @game.board[2] = "X "
  #   @game.board[3] = "O "
  #   @game.board[4] = "4 "
  #   @game.board[5] = "O "  
  #   @game.board[6] = "6 "
  #   @game.board[7] = "X "
  #   @game.board[8] = "8 "
  #   @game.board[9] = "9 "     
  #   @game.board[10] = "X "
  #   @game.board[11] = "11 "    
  #   @game.board[12] = "O "
  #   @game.board[13] = "13 "
  #   @game.board[14] = "14 "
  #   @game.board[15] = "15 "
  #   @game.board[16] = "16 "
  #   @game.board[17] = "O "
  #   @game.board[18] = "18 "
  #   @game.board[19] = "19 "
  #   @game.board[20] = "20 "
  #   @game.board[21] = "21 "
  #   @game.board[22] = "X "
  #   @game.board[23] = "23 "
  #   @game.board[24] = "24 "
  #   @game.shift_board(4,0,"O ").should be_true
  # end 
  
  # it "should have complex vertical shifts of the board" do
  #   @game.board[0] = "X "
  #   @game.board[1] = "O "
  #   @game.board[2] = "X "
  #   @game.board[3] = "O "
  #   @game.board[4] = "4 "
  #   @game.board[5] = "O "  
  #   @game.board[6] = "6 "
  #   @game.board[7] = "X "
  #   @game.board[8] = "8 "
  #   @game.board[9] = "9 "     
  #   @game.board[10] = "X "
  #   @game.board[11] = "11 "    
  #   @game.board[12] = "O "
  #   @game.board[13] = "13 "
  #   @game.board[14] = "14 "
  #   @game.board[15] = "15 "
  #   @game.board[16] = "16 "
  #   @game.board[17] = "O "
  #   @game.board[18] = "18 "
  #   @game.board[19] = "19 "
  #   @game.board[20] = "20 "
  #   @game.board[21] = "21 "
  #   @game.board[22] = "X "
  #   @game.board[23] = "23 "
  #   @game.board[24] = "24 "
  #   @game.shift_board(14,24,@game.board[14]).should be_true
  # end   
  
  # it "should have complex vertical shifts of the board" do
  #   @game.board[0] = "X "
  #   @game.board[1] = "O "
  #   @game.board[2] = "X "
  #   @game.board[3] = "O "
  #   @game.board[4] = "4 "
  #   @game.board[5] = "O "  
  #   @game.board[6] = "6 "
  #   @game.board[7] = "X "
  #   @game.board[8] = "8 "
  #   @game.board[9] = "9 "     
  #   @game.board[10] = "X "
  #   @game.board[11] = "11 "    
  #   @game.board[12] = "O "
  #   @game.board[13] = "13 "
  #   @game.board[14] = "14 "
  #   @game.board[15] = "15 "
  #   @game.board[16] = "16 "
  #   @game.board[17] = "O "
  #   @game.board[18] = "18 "
  #   @game.board[19] = "19 "
  #   @game.board[20] = "20 "
  #   @game.board[21] = "21 "
  #   @game.board[22] = "X "
  #   @game.board[23] = "23 "
  #   @game.board[24] = "24 "
  #   @game.shift_board(21,20,@game.board[21]).should be_true
  # end
  
  it "should be able to handle all the legal shifts of the board" do
    @game.board[0] = "X "
    @game.board[1] = "O "
    @game.board[2] = "X "
    @game.board[3] = "O "
    @game.board[4] = "4 "
    @game.board[5] = "O "  
    @game.board[6] = "6 "
    @game.board[7] = "X "
    @game.board[8] = "8 "
    @game.board[9] = "9 "     
    @game.board[10] = "X "
    @game.board[11] = "11 "    
    @game.board[12] = "O "
    @game.board[13] = "13 "
    @game.board[14] = "14 "
    @game.board[15] = "15 "
    @game.board[16] = "16 "
    @game.board[17] = "O "
    @game.board[18] = "18 "
    @game.board[19] = "19 "
    @game.board[20] = "20 "
    @game.board[21] = "21 "
    @game.board[22] = "X "
    @game.board[23] = "23 "
    @game.board[24] = "24 "
    @game.shift_board(0,20,@game.board[0]).should be_true
  end
    
end
