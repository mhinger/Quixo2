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

  def look_ahead
    tree = []
    (@possible_pulls.length).times do |i|
      tree[i] = legal_moves(@possible_pulls[i])
    end
    
    puts "#{tree}"    
  end
  
  def generate_legal_pull_pos(board)
    @count = @count + 1
    win_pos = 0
    pull = 0
    find_last_x_move
    find_open_moves
    x_row = check_for_xrows
    x_col = check_for_xcols
    o_row = check_for_orows
    o_col = check_for_ocols
    win_chance = check_for_win
    check_for_3_or_4
    row_middle = find_xs_in_row(x_row)
    col_middle = find_xs_in_col(x_col)
    if win_chance[0] == "row"
      @win_row = win_chance[1]
      win_pos = nil
      row = win_chance[1]
      row = row * 5
      win_col = nil
      5.times do |i|
        if @current_board[i + row] != "O"
          win_pos = i + row
        end
      end
      if win_pos != nil
        win_col = win_pos % 5
      end
      if win_chance[1] == 4
        open_spot = []
        loc = 0
        5.times do |i|
          if @current_board[i] != "X"
            open_spot[loc] = i
            loc = loc + 1
          end
        end 
        if win_pos != nil
          (open_spot.length).times do |i|
            if open_spot[i] == win_pos - 20
              @chance_to_win_horiz = true
              return win_pos - 20
            else
              @shift_need = true
              if open_spot[i] == win_pos - 19
                pull = 24
              elsif open_spot[i] >= 2
                pull = 24
              else
                pull = 20
              end
            end
          end
        end
        if win_col == 0 || win_col == 4
          5.times do |i|
            if @current_board[5 * i + win_col] != "X"
              @chance_to_win_horiz = true
              return (5 * i + win_col)
            end
          end              
        end
      end
    elsif win_chance[0] == "col"
    end
    if row_middle == nil
      5.times do |i|
        if @row_counts[i] == 4
          row_middle = i * 5 + 1
          if x_row == 0
            if @current_board[row_middle + 20] != "X"
              row_middle = row_middle
            end
          elsif x_row == 4
            if @current_board[row_middle - 20] != "X"
              @row_middle = row_middle
            end
          end
        end
      end
    end
    if col_middle == nil
        5.times do |i|
          if @col_counts[i] == 4
            col_middle =  i + 5
            if x_col == 0
              if @current_board[col_middle + 4] != "X"
                @col_middle = col_middle
              end
            end
          end
        end
      end
    if row_middle != nil
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
      elsif situation == "row block"
        puts "row block"
      else
        pos = pull_game_logic
      end
    elsif col_middle != nil
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
        if win_pos != nil 
          pos = try_and_win_horz(win_pos,pull)
        end
        if pos == nil
          pos = try_and_win_vert
          if pos == nil
            pos = pull_game_logic
          end
        end 
      end
      @row_of_xs = nil
      @col_of_xs = nil
    end  
    if @current_board[pos] == "X"
      pos = pull_game_logic
    end 
    return pos
  end
  
  def check_for_win
    5.times do |i|
      if @row_counts_o[i] == 4
        return ["row", i]
      elsif @col_counts_o[i] == 4
        return ["col", i]
      end
    end
    return ["",nil]
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
    pos = vert_spaces_to_win[rand(vert_spaces_to_win.length)]
    if vert_spaces_to_win != nil && pos != nil
      col = col_find(pos.to_i)
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
####Checks to see if the necessary pull piece is an X
      if @current_board[pos] == "X"
        pull_col = col_find(pos)
        if pull_col == 0
          pos = pos + 4
        elsif pull_col == 4
          pos = pos - 4
        end
####After finding out the necessary pull piece was an X, try the opposite piece
        pull_row = row_find(pos)
        if pull_row == 0 
          5.times do |i|
            if @current_board[i] != "X"
              pos = i
              break
            end
          end
        elsif pull_row == 4
          5.times do |i|
            if @current_board[i + 20] != "X"
              pos = i + 20
              break
            end
          end
        end
############ NOT DONE YET
        if @current_board[pos] == "X"
          if @win_col == 0 || @win_col == 4
            if @current_board[@win_col] != "X" && pos <= 10
              pos = pos - 5
            elsif @current_board[@win_col + 20] != "X"
              pos = pos + 5
            end
          else
            if @current_board[@win_col] == "O"
              pos = @win_col
            elsif @current_board[@win_col + 20] == "O"
              pos = @win_col + 20
            end
          end
        end
      end
      @chance_to_win_vert = true
      return pos
    end
    return nil
  end
  
  def try_and_win_horz(win_pos,pull)
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
    pos = horiz_spaces_to_win[rand(horiz_spaces_to_win.length)]
    if horiz_spaces_to_win != nil && pos != nil
      row = row_find(pos.to_i)
      col = col_find(pos)
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
      if row == 0
        if col == 0
        elsif col == 4
        end
      elsif row == 4
        if col == 0
        elsif col == 4
        end
      end
      if @current_board[pos] == "X"
        col = col_find(pos)
        row = row_find(pos)
        if col == 0 || col == 4
          5.times do |i|
            if @current_board[5 * i + col] != "X"
              pos = 5*i+col
            end
          end
        else
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
      @win_col = (moves[0]).to_i % 5
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
        return nil
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

  def check_for_ocols
    o_col = nil
    o_count = []
    5.times do |j|
      col = j
      o_count[col] = 0
      5.times do |i|
        row = col + 5 * i
        if @current_board[row] == "O"
          o_count[col] = o_count[col] + 1
        end
      end
    end
    5.times do |i|
      if o_count[i] == 4 || o_count[i] == 3
        o_col = i
      end
    end   
    @col_counts_o = o_count.clone
    return o_col
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
  
  def check_for_orows
    o_row = nil
    o_count = []
    5.times do |j|
      row = j
      o_count[row] = 0
      5.times do |i|
        col = row * 5 + i
        if @current_board[col] == "O"
          o_count[row] = o_count[row] + 1
        end
      end
    end
    5.times do |i|
      if o_count[i] == 4
        o_row = i
      elsif o_count[i] == 3
        o_row = i
      end
    end    
    @row_counts_o = o_count.clone
    return o_row
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
  
  def generate_legal_push_pos(pull)
################ Working on the vertical win opportunity for AI !!!!!!    
    if !@chance_to_win_horiz && !@chance_to_win_vert
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
      col = col_find(pull)
      if row == @win_row
        push = row * 5
      elsif row == 0
        push = pull + 20
      elsif row == 4
        push = pull - 20
      elsif row == 1
        push = 5 * @win_row + col
      elsif row == 2
        push = 5 * @win_row + col
      elsif row == 3
        push = 5 * @win_row + col
      end
      @chance_to_win_horiz = false
    elsif @chance_to_win_vert == true      
      col = col_find(pull)
      row = row_find(pull)
      if col == @win_col
        if col == 4
          if @current_board[pull - 4] != "X"
            push = col + 20
          elsif @current_board[pull + 6] != "X"
            push = col
          end
        elsif col == 0
          if @current_board[pull + 4] != "X"
            push = col + 20
          elsif @current_board[pull + 14] != "X"
            push = col
          end
        elsif col == 1
          if pull == @win_col
            push = 20 + pull
          else
            push = pull - 20
          end
        end
      elsif col == 0
        if @win_col == 0 || @win_col == 4
          push = col + 4
        else
          if pull == @win_col
            push = 20 + pull
          else
            push = 20 - pull
          end
        end
      elsif col == 1
        push = 5 * row + @win_col
      elsif col == 2
        push = 5 * row + @win_col
      elsif col == 3
        push = 5 * row + @win_col
      elsif col == 4
        push = pull - 4
      end
      @chance_to_win_vert = false
    end
    return push
  end
  
  def check_for_3_or_4
    5.times do |i|
      if @row_counts[i] == 4
      elsif @col_counts[i] == 4 
      elsif @row_counts_o[i] == 4 
      elsif @col_counts_o[i] == 4
      elsif @row_counts[i] == 3
      elsif @col_counts[i] == 3
      elsif @row_counts_o[i] == 3 
      elsif @col_counts_o[i] == 3
      end
    end
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
  end
  
  def push_game_logic(pull)
    if @count == 1
      legal_pos = legal_moves(pull)
      loc = rand(legal_pos.length)
      push = legal_pos[loc]
    else
      legal_pos = legal_moves(pull)   
      pos = rand(legal_pos.size)
      push = legal_pos[pos]
    end
    return push
  end
  
  def pull_game_logic
    if @count == 1
      pos = [0,4,20,24]
      loc = rand(4)
      pos = pos[loc]
    else
      pos = generate_rand_pos
      while @place.legal_pull_position(pos) == false
        if @current_board[pos] == "O"
          pos = generate_rand_pos
        elsif @current_board[pos] == "X"
          pos = generate_rand_pos
        else
          if @place.legal_pull_position(pos) == true
            return pos
          else
            pos = generate_rand_pos
          end
        end
      end
    end   
    return pos
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