class Game
  attr_reader :board
  attr_reader :prev_turn
  attr_reader :current_turn
  
  def initialize 
    @board = []
    @prev_turn = "O"
    @current_turn = "X"
  end
  
  def shift_board(pull_pos, push_pos, mark)
    puts ""
    puts "orig: #{@board}"
    x = (pull_pos - push_pos).abs / 5
    
    if pull_pos > push_pos
      puts "vertically down"
      @board[pull_pos] = @board[pull_pos - 5]
      @board[pull_pos - 5] = @board[pull_pos - 10]
      @board[pull_pos - 10] = @board[push_pos]
      @board[push_pos] = mark      
    elsif pull_pos < push_pos
      puts "vertically up"
      @board[pull_pos] = @board[pull_pos + 5]
      @board[pull_pos + 5] = @board[pull_pos +10]
      @board[pull_pos + 10] = @board[push_pos]
      @board[push_pos] = mark
    end
    

    puts "new: #{@board}"
    return true
    
  end
  
  def change_turn(new_turn)
    if new_turn == "X"
      @prev_turn = "O"
      @current_turn = new_turn
    elsif new_turn == "O"
      @prev_turn = "X"
      @current_turn = new_turn    
    else
      return false
    end
    return true
  end
  
  def victory?(mark)
    if diagonal_down_right_victory?(mark) or diagonal_up_right_victory?(mark)
      puts "#{mark} WINS!! #{mark} WINS!!"
      return true 
    end       
    5.times do |row|
      if horizontal_victory?(row, mark)
        puts "#{mark} WINS!! #{mark} WINS!!!"  
        return true     
      end         
    end
    5.times do |col|  
      if vertical_victory?(col, mark)
        puts "#{mark} WINS!! #{mark} WINS!!!"
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