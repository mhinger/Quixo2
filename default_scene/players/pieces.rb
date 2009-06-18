require "game"
# require "turn"
require "placement"

module Pieces
  
  def mouse_clicked(e)
  
    place = Placement.new

    if production.pull_position == nil
      if place.legal_pull_position((self.id).to_i)
        production.pull_position = (self.id).to_i
      end
    elsif place.legal_push_position(production.pull_position, (self.id).to_i)
      production.push_position = (self.id).to_i 
      
      if text == "" && production.game.current_turn == "X"
        self.text = "X"
        production.game.change_turn("O")
      elsif text == "" && production.game.current_turn == "O"
        self.text = "O"
        production.game.change_turn("X")
      end  
           
      # if text == "" && production.turn.current_turn == "X"
      #   self.text = "X" 
      #   production.turn.change_turn("O")
      # elsif text == "" && production.turn.current_turn == "O"
      #   self.text = "O"
      #   production.turn.change_turn("X")
      # end

      production.game.board[(self.id).to_i] = self.text
           
      # if production.turn.current_turn == "X"
      #   if production.game.victory?("O")
      #     puts "O Wins"
      #   end
      # elsif production.turn.current_turn == "O" 
      #   if production.game.victory?("X") 
      #     puts "X wins"  
      #   end
      # end 
      
      if production.game.current_turn == "X"
        production.game.victory?("O")
      elsif production.game.current_turn == "O" 
        production.game.victory?("X")   
      end
              
      production.pull_position = nil
    end
  end 
  
end