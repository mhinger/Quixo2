require 'spec_helper'
require 'ai'
require 'game'

describe Ai do
  
  before(:each) do
    @comp = Ai.new
    @game = Game.new
  end
  
  it "should find the middle of a string of x's" do
    @game.board[20] == "X"
    @game.board[21] == "X"
    @game.board[22] == "X"
    @game.board[23] == "O"
    @game.board[24] == "X"
    
    middle = @comp.find_xs_in_row(4)
    puts "#{middle}"
  end
  
  # it "should have a computer player" do
  #   @comp.player.should == "Joe"
  # end
  # 
  # it "should make a move" do
  #   pos = 23
  #   @game.board[0] = "X"
  #   @game.board[1] = "O"
  #   @game.board[2] = "X"
  #   @game.board[21] = "O"
  #   
  #   @comp.make_move(@game.board,pos)
  #   @game.board[pos].should == "O"
  # end
  # 
  # it "should find the first open position and make a move" do
  #   @game.board[0] = "X"
  #   @game.board[1] = "X"
  #   @game.board[3] = "O"
  #   @game.board[4] = "X"
  #   
  #   @comp.find_first_open_move(@game.board)
  #   @game.board[2].should == "O"
  # end
  # 
  # it "should have no open moves" do
  #   @game.board[0] = "X"
  #   @game.board[1] = "X"
  #   @game.board[2] = "O"
  #   @game.board[3] = "O"
  #   @game.board[4] = "X"
  #   @game.board[5] = "X"
  #   @game.board[6] = "X"
  #   @game.board[7] = "O"
  #   @game.board[8] = "X"
  #   @game.board[9] = "X"
  #   @game.board[10] = "X"
  #   @game.board[11] = "O"
  #   @game.board[12] = "X"
  #   @game.board[13] = "X"
  #   @game.board[14] = "X"
  #   @game.board[15] = "O"
  #   @game.board[16] = "X"
  #   @game.board[17] = "X"
  #   @game.board[18] = "X"
  #   @game.board[19] = "O"
  #   @game.board[20] = "X"
  #   @game.board[21] = "X"
  #   @game.board[22] = "X"
  #   @game.board[23] = "O"
  #   @game.board[24] = "X"
  #   
  #   @comp.find_first_open_move(@game.board).should be_false
  # end
  # 
  # it "should be able to determine legal pull positions" do
  #   @comp.find_legal_pull_pos(2).should be_true
  #   @comp.find_legal_pull_pos(17).should be_false
  # end
  # 
  # it "should be able to make a legal move" do
  #   if @comp.find_legal_pull_pos(2) == true
  #     @comp.make_move(@game.board,2)
  #     @game.board[2].should == "O"
  #   end
  # end
  # 
  # it "should not be able to make illegal moves" do
  #   @comp.make_move(@game.board,12).should be_false
  # end
  # 
  # it "should make a random legal move" do
  #   @comp.random_move(@game.board)
  # end
  # 
  # it "should be able to select a piece" do
  #   @game.board[0] = "X"
  #   @game.board[1] = "X"
  #   @game.board[2] = "O"
  #   @game.board[3] = " "
  #   @game.board[4] = "X"
  #   @game.board[5] = "X"
  #   @game.board[6] = "X"
  #   @game.board[7] = " "
  #   @game.board[8] = " "
  #   @game.board[9] = " "
  #   @game.board[10] = " "
  #   @game.board[11] = " "
  #   @game.board[12] = " "
  #   @game.board[13] = " "
  #   @game.board[14] = " "
  #   @game.board[15] = " "
  #   @game.board[16] = " "
  #   @game.board[17] = "X"
  #   @game.board[18] = "X"
  #   @game.board[19] = "O"
  #   @game.board[20] = "X"
  #   @game.board[21] = "X"
  #   @game.board[22] = "X"
  #   @game.board[23] = ""
  #   @game.board[24] = "X"
  #   
  #   
  #   @comp.select_piece(@game.board,@comp.generate_legal_pull_pos)
  #   
  #   puts "\n"
  #   puts "#{@game.board[0]},#{@game.board[1]},#{@game.board[2]},#{@game.board[3]},#{@game.board[4]}"
  #   puts "#{@game.board[5]},#{@game.board[6]},#{@game.board[7]},#{@game.board[8]},#{@game.board[9]}"
  #   puts "#{@game.board[10]},#{@game.board[11]},#{@game.board[12]},#{@game.board[13]},#{@game.board[14]}"
  #   puts "#{@game.board[15]},#{@game.board[16]},#{@game.board[17]},#{@game.board[18]},#{@game.board[19]}"
  #   puts "#{@game.board[20]},#{@game.board[21]},#{@game.board[22]},#{@game.board[23]},#{@game.board[24]}"
  # end
  
  # it "should be able to access the board" do
  #   @game.board[1] = "O"
  #   puts "#{@comp.get_board}"
  # end
  
end




