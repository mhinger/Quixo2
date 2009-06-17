require "game"
require "turn"
require "placement"

module Pieces
  
  def mouse_clicked(e)
  
    place = Placement.new
    game = Game.new

    if production.pull_position == nil
      if place.legal_pull_position((self.id).to_i)
        production.pull_position = (self.id).to_i
      end
    elsif place.legal_push_position(production.pull_position, (self.id).to_i)
        production.push_position = (self.id).to_i
        production.pull_position = nil
           
    if text == "" && production.turn.current_turn == "X"
      self.text = "X" 
      production.turn.change_turn("O")
    elsif text == "" && production.turn.current_turn == "O"
      self.text = "O"
      production.turn.change_turn("X")
    end
    
    25.times do |i|
      prop = scene.find(i.to_s)
      game.board[i] = prop.text
    end
        
    if production.turn.current_turn == "O"
      if game.victory?("X")
        puts "X WINS!!"
      end
    elsif production.turn.current_turn == "X"
      if game.victory?("O")
        puts "O WINS!!"
      end
    end
   end
   
    
    puts "pull: #{production.pull_position}"
    puts "push: #{production.push_position}"   
        
  end    
end