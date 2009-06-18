class Game
  attr_reader :board
  attr_reader :count
  attr_reader :count2
  attr_reader :col
  
  def initialize 
    @board = []
    @count = 0
    @count2 = 0
    @col = 4
  end
  
  def victory?(mark)
    puts "BOARD: #{@board}"
    5.times do |row|
      if horizontal_victory?(row, mark) # or vertical_victory?(col, mark)
        puts "#{mark} WINS!! #{mark} WINS!!!"          
        return true     
      end  
      
      if diagonal_down_right_victory?(row, mark) or diagonal_up_right_victory?(row, mark)
        puts "#{mark} WINS!! #{mark} WINS!!"
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
  
  def diagonal_down_right_victory?(row, mark)
    if (@board[row * 6] == mark)
      @count = @count + 1
    end
    if (@count == 5)
      return true
    end
    return false
  end
  
  def diagonal_up_right_victory?(row, mark)
    if (@board[row * 5 + @col] == mark)
      @count2 = @count2 + 1
    end
    
    if (@count2 == 5)
      return true
    end
    @col = @col - 1  
    return false
  end 
  
end