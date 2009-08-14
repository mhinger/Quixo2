require "game"
require "placement"

class Ai < Game
  attr_reader :player
  attr_reader :prev_board
  attr_reader :prev_prev_board
  attr_reader :current_board
  attr_reader :prev_x_move
  attr_reader :prev2_x_move
  attr_reader :prev_y_move
  attr_reader :possible_moves
  attr_reader :count
  attr_reader :possible_pulls
  
  def initialize
    @place = Placement.new
    @prev_prev_board = []
    @prev_board = []
    @current_board = []
    @count = 0
    @prev_x_move = nil
    @prev2_x_move = nil
    @prev_y_move = nil
    @possible_moves = []
    @push_pos = nil
    @pull_pos = nil
    @row_of_xs = nil
    @col_of_xs = nil
    @row_middle = nil
    @col_middle = nil
    @row_counts = []
    @col_counts = []
    @row_counts_o = []
    @col_counts_o = []
    @win_row = nil
    @win_col = nil
    @chance_to_win_horiz = false
    @chance_to_win_vert = false
    @placement_values = []
    @shift_need = false
    @possible_pulls = [0,1,2,3,4,5,9,10,14,15,19,20,21,22,23,24]
  end

  def find_open_moves
    25.times do |i|
      if @current_board[i] != "X"
        @possible_moves[i] = "true"
      else
        @possible_moves[i] = "false"
      end
    end
    @possible_moves[6] = "false"
    @possible_moves[7] = "false"
    @possible_moves[8] = "false"
    @possible_moves[11] = "false"
    @possible_moves[12] = "false"
    @possible_moves[13] = "false"
    @possible_moves[16] = "false"
    @possible_moves[17] = "false"
    @possible_moves[18] = "false"
  end
  
  def open_moves(board)
    possible_moves = []
    25.times do |i|
      if board[i] != "X"
        possible_moves[i] = true
      else
        possible_moves[i] = false
      end
    end
    possible_moves[6] = false
    possible_moves[7] = false
    possible_moves[8] = false
    possible_moves[11] = false
    possible_moves[12] = false
    possible_moves[13] = false
    possible_moves[16] = false
    possible_moves[17] = false
    possible_moves[18] = false    
    return possible_moves
  end

  def legal_moves(pos)
    if pos != nil
      if pos == 0
        legals = [4,20]
      elsif pos == 1
        legals = [0, 4, 21]
      elsif pos == 2
        legals = [0, 4, 22]
      elsif pos == 3
        legals = [0, 4, 23]
      elsif pos == 4
        legals = [0, 24]  
      elsif pos == 5
        legals = [0, 9, 20]  
      elsif pos == 9
        legals = [4, 5, 24]  
      elsif pos == 10
        legals = [0, 14, 20]
      elsif pos == 14
        legals = [4, 10, 24]
      elsif pos == 15
        legals = [0, 19, 20]
      elsif pos == 19
        legals = [4, 15, 24]
      elsif pos == 20
        legals = [0, 24]
      elsif pos == 21
        legals = [1, 20, 24]
      elsif pos == 22
        legals = [2, 20, 24]
      elsif pos == 23
        legals = [3, 20, 24]
      elsif pos == 24
        legals = [4, 20]    
      end
    end
    return legals
  end
  
  def set_prev_board(board)
    @prev_prev_board = @prev_board.clone
    @prev_board = board.clone
  end
  
  def set_current_board(board)
    @current_board = board.clone
  end
  
  def print_board(board)
    puts "#{board[0]},#{board[1]},#{board[2]},#{board[3]},#{board[4]}"
    puts "#{board[5]},#{board[6]},#{board[7]},#{board[8]},#{board[9]}"
    puts "#{board[10]},#{board[11]},#{board[12]},#{board[13]},#{board[14]}"
    puts "#{board[15]},#{board[16]},#{board[17]},#{board[18]},#{board[19]}"
    puts "#{board[20]},#{board[21]},#{board[22]},#{board[23]},#{board[24]}"
    puts ""
  end

end