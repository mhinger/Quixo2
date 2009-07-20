require 'spec_helper'
require 'ai'
require 'game'

describe Ai do
  
  before(:each) do
    @comp = Ai.new
    @game = Game.new
  end
  
  it "should see if the pull is in row 0 or 4" do
    @game.board[0] = "X"
    @game.board[1] = "X"
    @game.board[2] = ""
    @game.board[3] = ""
    @game.board[4] = "X"
    @game.board[5] = "O"
    @game.board[6] = "O"
    @game.board[7] = ""
    @game.board[8] = ""
    @game.board[9] = "X"
    @game.board[10] = "X"
    @game.board[11] = "X"
    @game.board[12] = ""
    @game.board[13] = ""
    @game.board[14] = ""
    @game.board[15] = "O"
    @game.board[16] = ""
    @game.board[17] = ""
    @game.board[18] = ""
    @game.board[19] = "" 
    @game.board[20] = "O"
    @game.board[21] = "X"
    @game.board[22] = "O"
    @game.board[23] = "O"   
    @game.board[24] = "O"
    
    
    @comp.set_current_board(@game.board)
    @comp.print_board(@comp.current_board)
    pull = @comp.generate_legal_pull_pos(@game.board)
    @comp.generate_legal_push_pos(pull)
  end
  
  
  
end




