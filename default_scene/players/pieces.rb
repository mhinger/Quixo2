require "game"
require "turn"
require "placement"

module Pieces
  
  def mouse_clicked(e)
    
    place = Placement.new

    game = Game.new

     if place.legal_pull_position((self.id).to_i)
      
      if text == "" && production.turn.current_turn == "X"
        self.text = "X" 
        production.turn.change_turn("O")
      elsif text == "" && production.turn.current_turn == "O"
        self.text = "O"
        production.turn.change_turn("X")
      end

        puts "previous turn: #{production.turn.prev_turn}"
        puts "current turn: #{production.turn.current_turn}"
    
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
        
        puts ""
    
    end    
  end    
end