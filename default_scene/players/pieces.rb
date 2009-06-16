require "game"
require "turn"
require "placement"

module Pieces
  
  def mouse_clicked(e)
    
    place = Placement.new
 
 ######## How do i get this to only execute once upon entry to the game, not every time the mouse is clicked?????
    turn = Turn.new
    turn.change_turn("X")

    game = Game.new

    if place.legal_pull_position((self.id).to_i)
      if text == "" && turn.current_turn == "X"
        self.text = "X"    
        # if (self.id).to_i % 2 == 0
        #   self.text = "X"
        # elsif (self.id).to_i % 2 == 1
        #   self.text = "O"
        # end
      end
    
     
       # if text == "" &&     
       #     if (self.id).to_i % 2 == 0
       #      self.text = "X"
       #     elsif (self.id).to_i % 2 == 1
       #      self.text = "O"
       #     end
       #    end        
       # 
       #    if text == 'X'
       #      self.text = "O"
       #    elsif text == ''
       #      self.text = "X"
       #    elsif text == 'O'
       #      self.text = ""
       #    end
   
        if turn.current_turn == "X"
          turn.change_turn("O")
        elsif turn.current_turn == "O"
          turn.change_turn("X")
        end
    
        puts "previous turn: #{turn.prev_turn}"
        puts "current turn: #{turn.current_turn}"

       # if text == ""
       #   if @turn.current_turn == "X"
       #     self.text = "X"
       #     @turn.change_turn("O")
       #   elsif turn.current_turn == "O"
       #     self.text = "O"
       #     @turn.change_turn("X")
       #   end
       # end
       #  
       # turn.current_turn = "X"
       # puts @turn.current_turn
       #  
       # if turn.current_turn == "X"
       #   self.text = "X"
       #   puts turn.current_turn
       #   turn.change_turn("O") 
       #   puts turn.current_turn         
       # elsif turn.current_turn == "O"
       #   self.text = "O"
       # end
        
        # game = Game.new
    
        25.times do |i|
          prop = scene.find(i.to_s)
          game.board[i] = prop.text
        end
        
        puts "X victory? #{game.victory?("X")}"
    
    end    
  
  end    
end