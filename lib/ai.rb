
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
    @row_counts = []
    @col_counts = []
    @win_row = nil
    @win_col = nil
    @chance_to_win_horz = false
    @chance_to_win_vert = false
  end

  def generate_legal_pull_pos(board)
    @count = @count + 1
    
    find_last_x_move
    find_open_moves
    x_row = check_for_xrows
    x_col = check_for_xcols
    
    # puts "X_Row: #{x_row}"
    # puts "X_Col: #{x_col}"
    # puts "Row Counts: #{@row_counts}"
    # puts "Col Counts: #{@col_counts}"
    
    row_middle = find_xs_in_row(x_row)
    # puts "Row_Middle: #{row_middle}"
    col_middle = find_xs_in_col(x_col)
    # puts "Col_Middle: #{col_middle}"
        
    if row_middle != nil   #x_row != nil
      num = rand(2) * 4
      @row_of_xs = x_row
      if x_row == 0 
        pos = find_pull_row(4,x_row,row_middle)
      elsif x_row == 1
        pos = find_pull_row(num,x_row,row_middle)
      elsif x_row == 2
        pos = find_pull_row(num,x_row,row_middle)
      elsif x_row == 3
        pos = find_pull_row(num,x_row,row_middle)
      elsif x_row == 4
        pos = find_pull_row(0,x_row,row_middle)
      else
        pos = pull_game_logic
      end

    elsif col_middle != nil#x_col != nil
      @col_of_xs = x_col
      if x_col == 0
        pos = find_pull_col(4,x_col,col_middle)
      elsif x_col == 1
        pos = find_pull_col(4,x_col,col_middle)
      elsif x_col == 2
        pos = find_pull_col(4,x_col,col_middle)
      elsif x_col == 3
        pos = find_pull_col(0,x_col,col_middle)
      elsif x_col == 4
        pos = find_pull_col(0,x_col,col_middle)
      else
        pos = pull_game_logic
      end
                
    else 
      if @count == 1
        pos = pull_game_logic
      else 
        pos = try_and_win_horz
        if pos == nil
          pos = try_and_win_vert
          if pos == nil
            pos = pull_game_logic
          end
        end 
      end
      # pos = pull_game_logic
      @row_of_xs = nil
    end  
     
    return pos
  end
  
  def try_and_win_vert
    board = @current_board.clone
    positions = []
    loc = 0
    pos = nil
    25.times do |i|
      if board[i] == "O"
        positions[loc] = i
        loc = loc + 1
      end
    end
    vert_spaces_to_win = check_vert_win(positions)
    puts "Spaces to Win Vertical: #{vert_spaces_to_win}"
    pos = vert_spaces_to_win[rand(vert_spaces_to_win.length)]
    puts "Pull Pos: #{pos}"
    if vert_spaces_to_win != nil && pos != nil
      puts "Vert Pos: #{pos}"
      col = col_find(pos.to_i)
      puts "Vert Col: #{col}"
      if col == 0 
        pos = pos + 4
      elsif col == 1 
        pos = pos + 3
      elsif col == 2
        pos = pos + 2
      elsif col == 3
        pos = pos - 3
      elsif col == 4
        pos = pos - 4
      end
      if @current_board[pos] == "X"
        col = col_find(pos)
        if col == 0
          pos = pos + 4
        elsif col == 4
          pos = pos - 4
        end
      end
      @chance_to_win_vert = true
      return pos
    end
    return nil
  end
  
  def try_and_win_horz
    board = @current_board.clone
    positions = []
    loc = 0
    pos = nil
    25.times do |i|
      if board[i] == "O"
        positions[loc] = i
        loc = loc + 1
      end
    end
    horiz_spaces_to_win = check_horz_win(positions)
    puts "Spaces to Win Horiz: #{horiz_spaces_to_win}"
    pos = horiz_spaces_to_win[rand(horiz_spaces_to_win.length)]
    if horiz_spaces_to_win != nil && pos != nil
      puts "Pos: #{pos}"
      row = row_find(pos.to_i)
      puts "Row: #{row}"
      if row == 0 
        pos = pos + 20
      elsif row == 1 
        pos = pos + 15
      elsif row == 2
        pos = pos + 10
      elsif row == 3
        pos = pos - 15
      elsif row == 4
        pos = pos - 20
      end
      if @current_board[pos] == "X"
        row = row_find(pos)
        if row == 0
          pos = pos + 20
        elsif row == 4
          pos = pos - 20
        end
      end
      @chance_to_win_horiz = true
      return pos
    end
    return nil
  end
  
  def check_horz_win(pos)
    rows = [0,0,0,0,0]
    row = nil
    moves = []
    loc = 0
    spaces = []
    (pos.length).times do |i|
      row = row_find(pos[i])
      if row == 0
        rows[0] = rows[0] + 1
      elsif row == 1
        rows[1] = rows[1] + 1
      elsif row == 2
        rows[2] = rows[2] + 1
      elsif row == 3
        rows[3] = rows[3] + 1  
      elsif row == 4
        rows[4] = rows[4] + 1
      end
    end
    5.times do |i|
      if rows[i] >= 3
        (pos.length).times do |j|
          if row_find(pos[j]) == i
            moves[loc] = pos[j]
            loc = loc + 1
          end
        end
      end 
    end
    if moves[0] != nil
      @win_row = (moves[0]).to_i / 5
      5.times do |i|
        spaces[i] = @win_row * 5 + i
      end   
      5.times do |i|
        (moves.length).times do |j|
          if moves[j] == spaces[i]
            spaces.slice!(i)
          end
        end
      end
    end  
    return spaces
  end
  
  def check_vert_win(pos)
    cols = [0,0,0,0,0]
    col = nil
    moves = []
    loc = 0
    spaces = []
    (pos.length).times do |i|
      col = col_find(pos[i])
      if col == 0
        cols[0] = cols[0] + 1
      elsif col == 1
        cols[1] = cols[1] + 1
      elsif col == 2
        cols[2] = cols[2] + 1
      elsif col == 3
        cols[3] = cols[3] + 1  
      elsif col == 4
        cols[4] = cols[4] + 1
      end
    end
    5.times do |i|
      if cols[i] >= 3
        (pos.length).times do |j|
          if col_find(pos[j]) == i
            moves[loc] = pos[j]
            loc = loc + 1
          end
        end
      end 
    end
    if moves[0] != nil
      @win_col = (moves[0]).to_i / 5
      5.times do |i|
        spaces[i] = @win_col + 5 * i
      end   
      5.times do |i|
        (moves.length).times do |j|
          if moves[j] == spaces[i]
            spaces.slice!(i)
          end
        end
      end
    end  
    return spaces
  end
  
  def find_pull_col(col,xcol,middle)
    if col == 0 
      if xcol == 3
        middle = middle - 3
      elsif xcol == 4
        middle = middle - 4
      end
    elsif col == 4
      if xcol == 0
        middle = middle + 4
      elsif xcol == 1
        middle = middle + 3
      elsif xcol == 2
        middle = middle + 2
      end
    end
    
    if @current_board[middle] != "X"
      return middle
    elsif @current_board[middle - 5] != "X"
      return middle - 5
    elsif @current_board[middle + 5] != "X"
      return middle + 5
    elsif col == 0
      if @current_board[middle + 4] != "X"
        return middle + 4
      elsif @current_board[middle - 1] != "X"
        return middle - 1
      elsif @current_board[middle + 9] != "X"
        return middle + 9
      end
    elsif col == 4
      if @current_board[middle - 4] != "X"
        return middle - 4
      elsif @current_board[middle + 1] != "X"
        return middle + 1
      elsif @current_board[middle - 9] != "X"
        return middle - 9
      end
    else
      return pull_game_logic
    end
    
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
    elsif @current_board[middle - 1] != "X"
      return middle - 1
    elsif @current_board[middle + 1] != "X"
      return middle + 1
    elsif row == 0
      if @current_board[middle + 20] != "X"
        return middle + 20
      elsif @current_board[middle + 21] != "X"
        return middle + 21
      elsif @current_board[middle + 19] != "X"
        return middle + 19
      end
    elsif row == 4
      if @current_board[middle - 20] != "X"
        return middle - 20
      elsif @current_board[middle - 21] != "X"
        return middle - 21
      elsif @current_board[middle - 19] != "X"
        return middle - 19
      end
    else
      return pull_game_logic        
    end
  end
  
  def find_xs_in_col(xcol)
    if xcol == nil
      return nil
    else
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
        if (i + 1) < 5
          if count >= 3 && board[i + 1] != "X"
            break
          end
        end
      end
    
      if count >= 3
        middle = find_middle_col(xcol,count,board)
        @col_middle = middle
        return middle
      else
        @col_middle = nil
      end  
    end
  end
  
  def find_xs_in_row(xrow)
    if xrow == nil
      return nil
    else
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
        middle = find_middle_row(xrow,count,board)
        @row_middle = middle
        return middle
      else
        @row_middle = nil
        return nil ### just added may or may not work
      end
    end
  end
  
  def find_middle_col(xcol,count,board)
    pos = []
    loc = 0
    5.times do |i|
      if board[i] == "X"
        pos[loc] = xcol + 5 * i
        loc = loc + 1
      end
    end
    
    (pos.length).times do |i|
      if (i - 1) >= 0
        if pos[i] != (pos[i-1] + 5)
          pos.slice!(i)
        end
      end
    end
    return pos[pos.length/2]
  end
  
  def find_middle_row(xrow,count,board)
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
    @col_counts = x_count.clone
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
    @row_counts = x_count.clone
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
    puts "Pull for legal_push_pos: #{pull}"
    # puts "row of xs from legal_push_pos: #{@row_of_xs}"
    # puts "col of xs from legal_push_pos: #{@col_of_xs}"
    # puts "Row Middle: #{@row_middle}"
    # puts "Col Middle: #{@col_middle}"
    
    
################ Working on the vertical win opportunity for AI !!!!!!    
    
    if @chance_to_win_horiz == false && @chance_to_win_vert == false
      if @row_middle != nil
        mid_row = row_find(@row_middle)
        if mid_row == 0 || mid_row == 1 || mid_row == 2     
          push = pull - 20 
        elsif mid_row == 4 || mid_row == 3
          push = pull + 20
        end 
        @row_middle = nil
      elsif @col_middle != nil
        mid_col = col_find(@col_middle)
        if mid_col == 0 || mid_col == 1 || mid_col == 2     
          push = pull - 4
        elsif mid_col == 4 || mid_col == 3
          push = pull + 4
        end  
        @col_middle = nil      
      else
        push = push_game_logic(pull)
      end    
    elsif @chance_to_win_horiz == true
      row = row_find(pull)
      if row == @win_row
        push = row * 5
      elsif row == 0
        push = pull + 20
      elsif row == 4
        push = pull - 20
      end
    elsif @chance_to_win_vert == true
      col = col_find(pull)
      puts "#{col}"
      
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