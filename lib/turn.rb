class Turn
  attr_reader :prev_turn
  attr_reader :current_turn
  
  def initialize
    @prev_turn = "O"    
    @current_turn = "X"
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
    
end