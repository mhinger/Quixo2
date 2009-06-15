require "game"

module Pieces
  
  def mouse_clicked(e)
    if text == 'X'
      self.text = "O"
    elsif text == ''
      self.text = "X"
    elsif text == 'O'
      self.text = ""
    end
    
    game = Game.new
    
    25.times do |i|
      prop = scene.find(i.to_s)
      game.board[i] = prop.text
    end
    
    puts game.victory?("X")
    
  end
  
 
  
  def next_turn(turn)
    if turn == 1
      self.id = "X"
    else
      self.id = "O"
    end
  end
    
end