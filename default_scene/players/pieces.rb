require "game"
require "turn"

module Pieces
 
  @turn = Turn.new
 
  
  def mouse_clicked(e)

    
    if text == 'X'
      self.text = "O"
    elsif text == ''
      self.text = "X"
    elsif text == 'O'
      self.text = ""
    end
  
#    turn.current_turn = "X"

#    if text == ""
#      if @turn.current_turn == "X"
#        self.text = "X"
#        @turn.change_turn("O")
#      elsif turn.current_turn == "O"
#        self.text = "O"
#        @turn.change_turn("X")
#      end
#    end
    
#    turn.current_turn = "X"
#    puts @turn.current_turn
    
  #  if turn.current_turn == "X"
  #    self.text = "X"
  #    puts turn.current_turn
  #    turn.change_turn("O") 
  #    puts turn.current_turn         
 #   elsif turn.current_turn == "O"
#      self.text = "O"
 #   end
    
    
    
    game = Game.new
    
    25.times do |i|
      prop = scene.find(i.to_s)
      game.board[i] = prop.text
    end
        
    puts "X victory? #{game.victory?("X")}"
    puts "O victory? #{game.victory?("O")}"

    
  end
    
end