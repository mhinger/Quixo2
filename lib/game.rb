class Game
  attr_reader :board
  attr_reader :prev_turn
  attr_reader :current_turn
  attr_reader :win_row
  attr_reader :win_col
  attr_reader :diag_win
  attr_reader :winning_mark
    
  def initialize
    @board = []
    @prev_turn = ""
    @current_turn = "X"
    @win_row = nil
    @win_col = nil
    @diag_win = ""
    @winning_mark = ""
  end
  
  def shift_board(pull_pos, push_pos, mark)
    x = (pull_pos - push_pos).abs / 5
###########Row Movement
    if x <= 4 && x >= 1
###########From any Row to Row 0 movement
      if pull_pos > push_pos
        x.times do |i|
          @board[pull_pos - (5 * i)] = @board[pull_pos - (5 * (i+1))]
        end
###########From any Row to Row 4 movement   
      elsif pull_pos < push_pos
        x.times do |i|
          @board[pull_pos + (5 * i)] = @board[pull_pos + (5 * (i+1))]
        end
      end
##########Col Movement
    elsif x == 0
##########From any Col to Col 4 movement  
      y = (pull_pos - push_pos).abs
      if pull_pos < push_pos
        y.times do |i|
          @board[pull_pos + i] = @board[pull_pos + (i + 1)]
        end
##########From any Col to Col 0 movement        
      elsif pull_pos > push_pos
        y.times do |i|
          @board[pull_pos - i] = @board[pull_pos - (i + 1)]
        end       
      end 
    end   
    @board[push_pos] = mark          
  end
  
  def board_shift(pull_pos, push_pos, mark, new_board)
    board = new_board.clone
    x = (pull_pos - push_pos).abs / 5
###########Row Movement
    if x <= 4 && x >= 1
###########From any Row to Row 0 movement
      if pull_pos > push_pos
        x.times do |i|
          board[pull_pos - (5 * i)] = board[pull_pos - (5 * (i+1))]
        end
###########From any Row to Row 4 movement   
      elsif pull_pos < push_pos
        x.times do |i|
          board[pull_pos + (5 * i)] = board[pull_pos + (5 * (i+1))]
        end
      end
##########Col Movement
    elsif x == 0
##########From any Col to Col 4 movement  
      y = (pull_pos - push_pos).abs
      if pull_pos < push_pos
        y.times do |i|
          board[pull_pos + i] = board[pull_pos + (i + 1)]
        end
##########From any Col to Col 0 movement        
      elsif pull_pos > push_pos
        y.times do |i|
          board[pull_pos - i] = board[pull_pos - (i + 1)]
        end       
      end 
    end   
    board[push_pos] = mark
    return board.clone       
  end
  
  def change_turn
    if @current_turn == "X"
      @prev_turn = "X"
      @current_turn = "O"
    elsif @current_turn == "O"
      @prev_turn = "O"
      @current_turn = "X"
    else
      return false
    end
    return true
  end
  
  def victory?(mark)
    if diagonal_down_right_victory?(mark)
      @diag_win = "down_right"
      @winning_mark = mark
      return true 
    elsif diagonal_up_right_victory?(mark)
      @diag_win = "up_right"
      @winning_mark = mark
      return true
    end       
    5.times do |row|
      if horizontal_victory?(row, mark)
        @win_row = row
        @winning_mark = mark
        return true
      end         
    end
    5.times do |col|  
      if vertical_victory?(col, mark)
        @win_col = col
        @winning_mark = mark
        return true
      end
    end
    return false
  end

private #########
  
  def row_offset(row)
    return row * 5
  end
  
  def horizontal_victory?(row, mark)
    if (@board[row_offset(row) + 0] == mark && 
        @board[row_offset(row) + 1] == mark && 
        @board[row_offset(row) + 2] == mark && 
        @board[row_offset(row) + 3] == mark && 
        @board[row_offset(row) + 4] == mark)
      return true
    end
    return false
  end
  
  def vertical_victory?(col, mark)
    if (@board[col + 0] == mark && 
        @board[col + 5] == mark && 
        @board[col + 10] == mark && 
        @board[col + 15] == mark && 
        @board[col + 20] == mark)
      return true
    end
    return false
  end
  
  def diagonal_down_right_victory?(mark)
    if (@board[0] == mark && 
        @board[6] == mark && 
        @board[12] == mark && 
        @board[18] == mark && 
        @board[24] == mark)
      return true
    end
    return false
  end
  
  def diagonal_up_right_victory?(mark)
    if (@board[20] == mark && 
        @board[16] == mark && 
        @board[12] == mark && 
        @board[8] == mark && 
        @board[4] == mark)
      return true
    end
    return false   
  end 
  
end