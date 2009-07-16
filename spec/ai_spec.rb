require 'spec_helper'
require 'ai'
require 'game'

describe Ai do
  
  before(:each) do
    @comp = Ai.new
    @game = Game.new
  end
  
  it "should try not to pull an O piece" do
    @game.board[0] = "O"
    @game.board[3] = ""
    @game.board[19] = "O"
    @game.board[22] = "O"
    @game.board[20] = "O"
    @game.board[10] = ""
    @game.board[1] = "O"
    @game.board[2] = "O"
    @game.board[4] = "O"
    @game.board[5] = "O"
    @game.board[15] = "O"
    @game.board[9] = "O"
    @game.board[14] = ""
    @game.board[21] = "O"
    @game.board[23] = ""
    @game.board[24] = "O"

    @comp.set_current_board(@game.board)
    @comp.print_board(@comp.current_board)
    pos = @comp.pull_game_logic
    puts "Pull Pos: #{pos}"
  end
  
  # it "should see if the pull is in row 0 or 4" do
  #   @game.board[0] = "O"
  #   @game.board[1] = ""
  #   @game.board[2] = ""
  #   @game.board[3] = "X"
  #   @game.board[4] = "O"
  #   @game.board[5] = "O"
  #   @game.board[6] = ""
  #   @game.board[7] = "O"
  #   @game.board[8] = ""
  #   @game.board[9] = "X"
  #   @game.board[10] = "O"
  #   @game.board[11] = ""
  #   @game.board[12] = ""
  #   @game.board[13] = "X"
  #   @game.board[14] = "O"
  #   @game.board[15] = "O"
  #   @game.board[16] = ""
  #   @game.board[17] = "X"
  #   @game.board[18] = ""
  #   @game.board[19] = "" 
  #   @game.board[20] = "X"
  #   @game.board[21] = ""
  #   @game.board[22] = "X"
  #   @game.board[23] = ""   
  #   @game.board[24] = "X"
  #   
  #   
  #   @comp.set_current_board(@game.board)
  #   @comp.print_board(@comp.current_board)
  #   pull = @comp.try_and_win_vert
  #   puts "Pull: #{pull}"
  #   @comp.generate_legal_push_pos(pull)
  # end
  
  
  
end




