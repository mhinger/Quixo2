
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
  end

  def generate_legal_pull_pos(board)
    @count = @count + 1

    puts "prev prev: "
    print_board(@prev_prev_board)
    puts "prev:"
    print_board(@prev_board)
    puts "current:"
    print_board(@current_board)
    
    find_last_x_move
    find_open_moves
    x_row = check_for_xrows
    x_col = check_for_xcols
      
    puts "x_col: #{x_col}"  
                      
    if x_row != nil
      @row_of_xs = x_row
      middle = find_xs_in_row(x_row)
      if middle != nil
        if x_row == 0 
          pos = find_pull_row(4,x_row,middle)
        elsif x_row == 1
          pos = find_pull_row(4,x_row,middle)
        elsif x_row == 2
          pos = find_pull_row(4,x_row,middle)
        elsif x_row == 3
          pos = find_pull_row(0,x_row,middle)
        elsif x_row == 4
          pos = find_pull_row(0,x_row,middle)
        else
          pos = pull_game_logic
        end
      else
        pos = pull_game_logic
      end
    
    elsif x_col != nil
      @col_of_xs = x_col
      middle = find_xs_in_col(x_col)
      puts "middle of col: #{middle}"
      pos = pull_game_logic
    
    else   
      pos = pull_game_logic
      @row_of_xs = nil
    end   
    return pos
  end
  
  def find_pull_row(row,xrow,middle)
    if row == 0
      if xrow == 3
        middle = middle - 15
      elsif xrow == 4
        middle = middle - 20
      end
    elsif row == 4
      if xrow == 0
        middle = middle + 20
      elsif xrow == 1
        middle = middle + 15
      elsif xrow == 2
        middle = middle + 10
      end
    end
    
    if @current_board[middle] != "X"
      return middle  
    else
      return middle - 1
    end
    
  end
  
  def find_xs_in_col(xcol)
    board = @current_board.clone
    start = xcol
    b = []
    5.times do |i|
      b[i] = board[start + 5 * i]
    end
    board = b.clone
    count = 0
    (board.length).times do |i|
      if board[i] == "X"
        count = count + 1
      else
        count = 0
      end
    end
    
    puts "#{board}"
  
  end
  
  def find_xs_in_row(xrow)
    board = @current_board.clone
    start = xrow * 5
    b = []
    5.times do |i|
      b[i] = board[i + start]
    end
    board = b.clone
    count = 0 
    (board.length).times do |i|
      if board[i] == "X"
        count = count + 1
      else
        count = 0
      end
      if (i + 1) < 5
        if count >= 3 && board[i+1] != "X"
          break
        end
      end
    end
      
    if count >= 3
      middle = find_middle(xrow,count,board)
      @row_middle = middle
      return middle
    else
      @row_middle = nil
    end
  end
  
  def find_middle(xrow,count,board)
    pos = []
    loc = 0
    5.times do |i|
      if board[i] == "X"
        pos[loc] = xrow * 5 + i
        loc = loc + 1
      end
    end
    
    (pos.length).times do |i|
      if (i - 1) >= 0
        if pos[i] != (pos[i - 1] + 1)
          pos.slice!(i)
        end
      end
    end 
    return pos[pos.length/2]
  end
  
  def check_for_xcols
    x_col = nil
    x_count = []
    5.times do |j|
      col = j
      x_count[col] = 0
      5.times do |i|
        row = col + 5 * i
        if @current_board[row] == "X"
          x_count[col] = x_count[col] + 1
        end
      end
    end
    
    5.times do |i|
      if x_count[i] == 4 || x_count[i] == 3
        x_col = i
      end
    end
    return x_col
  end
  
  def check_for_xrows
    x_row = nil
    x_count = []
    5.times do |j|
      row = j
      x_count[row] = 0
      5.times do |i|
        col = row * 5 + i
        if @current_board[col] == "X"
          x_count[row] = x_count[row] + 1
        end
      end
    end
    
    5.times do |i|
      if x_count[i] == 4
        x_row = i
      elsif x_count[i] == 3
        x_row = i
      end
    end    
    return x_row
  end
  
  def find_open_moves
    25.times do |i|
      if @current_board[i] != "X"
        @possible_moves[i] = "true"
      else
        @possible_moves[i] = "false"
      end
    end
    @possible_moves[6] = false
    @possible_moves[7] = false
    @possible_moves[8] = false
    @possible_moves[11] = false
    @possible_moves[12] = false
    @possible_moves[13] = false
    @possible_moves[16] = false
    @possible_moves[17] = false
    @possible_moves[18] = false
  end
  
  def generate_legal_push_pos(pull)
    
    pull_row = row_find(pull)
    pull_col = col_find(pull)
    
    puts "Pull for legal_push_pos: #{pull}"
    puts "row of xs from legal_push_pos: #{@row_of_xs}"
    
    ############ Problem lies in these two cases
    
    if @row_middle != nil
      mid_row = row_find(@row_middle)
      mid_col = col_find(@row_middle)
      if mid_row == 0 || mid_row == 1 || mid_row == 2     
        push = pull - 20 
      elsif mid_row == 4 || mid_row == 3
        push = pull + 20
      end 
    elsif @col_middle != nil
      
    else
      push = push_game_logic(pull)
    end    
    
    return push
  end
  
  def find_last_x_move
    pos = 0 
    25.times do |i|
      if @prev_board[i] != @current_board[i]
        pos = i
      end
    end
    
    @prev2_x_move = @prev_x_move
    @prev_x_move = pos
    
    puts "2 ago: #{@prev2_x_move}"
    puts "1 ago: #{@prev_x_move}"
  end
  
  def push_game_logic(pull)
    legal_pos = legal_moves(pull)
    if @count == 1
      pos = [0,4,20,24]
      loc = rand(4)
      return pos[loc]
    else
      pos = rand(legal_pos.size)
      push = legal_pos[pos]
      return push
    end
  end
  
  def pull_game_logic
    # if @count == 1
    #   pos = [0,4,20,24]
    #   loc = rand(4)
    #   puts "#{pos[loc]}"
    #   return pos[loc]
    #   return 2
    # else
      pos = generate_rand_pos
      while @place.legal_pull_position(pos) == false
        pos = generate_rand_pos
      end
      return pos
    # end
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

  def generate_rand_pos
    return rand(25)
  end

  def victory?(mark)
    if diagonal_down_right_victory?(mark) or diagonal_up_right_victory?(mark)
      return true 
    end       
    5.times do |row|
      if horizontal_victory?(row, mark)
        return true     
      end         
    end
    5.times do |col|  
      if vertical_victory?(col, mark)
        return true
      end
    end
    return false
  end

private ###########
  def row_find(pos)
    return pos / 5
  end

  def col_find(pos)
    return pos % 5
  end

  def row_offset(row)
    return row * 5
  end
  
  def horizontal_victory?(row, mark)
    if (@current_board[row_offset(row) + 0] == mark && 
        @current_board[row_offset(row) + 1] == mark && 
        @current_board[row_offset(row) + 2] == mark && 
        @current_board[row_offset(row) + 3] == mark && 
        @current_board[row_offset(row) + 4] == mark)
      return true
    end
    return false
  end
  
  def vertical_victory?(col, mark)
    if (@current_board[col + 0] == mark && 
        @current_board[col + 5] == mark && 
        @current_board[col + 10] == mark && 
        @current_board[col + 15] == mark && 
        @current_board[col + 20] == mark)
      return true
    end
    return false
  end
  
  def diagonal_down_right_victory?(mark)
    if (@current_board[0] == mark && 
        @current_board[6] == mark && 
        @current_board[12] == mark && 
        @current_board[18] == mark && 
        @current_board[24] == mark)
      return true
    end
    return false
  end
  
  def diagonal_up_right_victory?(mark)
    if (@current_board[20] == mark && 
        @current_board[16] == mark && 
        @current_board[12] == mark && 
        @current_board[8] == mark && 
        @current_board[4] == mark)
      return true
    end
    return false   
  end

  
end