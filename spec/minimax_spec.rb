require "spec_helper"
require "minimax"
require "game"
require "ai"

describe Minimax do
  before(:each) do
    @minmax = Minimax.new
    @game = Game.new
    @tree = [[[[[5, 11], [2, 7]], [[13, 16], [12, 10]]], [[[3, 9], [7, 12]], [[9, 11], [8, 16]]]]]
    @ai = Ai.new
    @game.board[0] = "O"
    @game.board[1] = ""
    @game.board[2] = ""
    @game.board[3] = ""
    @game.board[4] = ""
    @game.board[5] = "O"
    @game.board[6] = ""
    @game.board[7] = ""
    @game.board[8] = ""
    @game.board[9] = ""
    @game.board[10] = "X"
    @game.board[11] = ""
    @game.board[12] = ""
    @game.board[13] = ""
    @game.board[14] = ""
    @game.board[15] = "O"
    @game.board[16] = "O"
    @game.board[17] = ""
    @game.board[18] = ""
    @game.board[19] = ""
    @game.board[20] = "X"
    @game.board[21] = "X"
    @game.board[22] = "X"
    @game.board[23] = "X"
    @game.board[24] = "O"
  end

  it "should minimax look through" do
    tree = @minmax.minimax(@tree[0],0,5)
    puts tree
  end
  
  it "should alpha beta look through" do
    tree = @minmax.alpha_beta(@tree[0],0,-100,100,5)
    puts tree
  end
  
  it "should determine all possible moves for a board" do  
    moves = @minmax.evaluate_board(@game.board)
  end

  it "should determine a score for a given board" do
    @game.board[14] = "O"
    score = @minmax.score_for(@game.board, "O")
    
  end
    
  it "should determine how many rows have 5 pieces of the same mark in them" do
    five_in_line = @minmax.five_in_a_line(@game.board,"O")
  end
  
  it "should determine how many cols have 5 pieces of the same mark in them" do
    five_in_line = @minmax.five_in_a_line(@game.board,"O")
  end
  
  it "should determine how many rows, cols and diags with 5 of the same mark" do
    five_in_line = @minmax.five_in_a_line(@game.board,"O")
  end
  
  it "should determine if there are 4 pieces of the same mark" do
    four_in_line = @minmax.four_in_a_line(@game.board,"O")
  end

  it "should determine if there are 3 pieces of the same mark" do
    three_in_line = @minmax.three_in_a_line(@game.board,"O")
  end
  
  it "should determine if there are 2 pieces of the same mark" do
    two_in_line = @minmax.two_in_a_line(@game.board,"O")
  end
  
  it "should determine if there are any corner pieces of the same mark" do
    corner_pieces = @minmax.corner_pieces(@game.board,"O")
  end
  
  it "should calculate the score for a given board" do
    score = @minmax.score_for(@game.board,"O")
  end
  
  it "should shift a board" do
    board = @minmax.shift_board(0,4,"O",@game.board)
  end
  
  it "should do all the possible push/pulls" do
    # @minmax.evaluate_possible_moves(@game.board,"O")
  end
  
  it "should return the best possible move" do
    # puts ""
    # puts "Orig Board"
    # @ai.print_board(@game.board)
    # best_move = @minmax.evaluate_possible_moves(@game.board,"O")
    # puts best_move
    # @game.shift_board(best_move[0],best_move[1],"O")
    # @ai.print_board(@game.board)
  end
  
  it "should see if there is a win opportunity FOR X on the next turn" do
    puts ""
    puts "Before:"
    @ai.print_board(@game.board)
    best_move = @minmax.evaluate_possible_moves(@game.board,"O","unbeatable")
    puts best_move[0]
    puts best_move[1]
    puts best_move[2]
    # best_move = @minmax.four_in_a_line_win_opportunity(@game.board,"O")
    # puts best_move
    # best_move = @minmax.four_in_a_line_win_opportunity(@game.board,"X")
    # puts best_move
  end

end














