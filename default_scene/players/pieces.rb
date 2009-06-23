require "game"
require "placement"

module Pieces
  
  prop_reader :board
  
  def mouse_clicked(e)  
    place = Placement.new   
    if production.pull_position == nil
      if place.legal_pull_position((self.id).to_i)
        if production.game.board[(self.id).to_i] == "X"
          if production.game.current_turn == "X"
            puts "An X was pulled"
            puts ""
            production.pull_position = (self.id).to_i
          elsif production.game.current_turn == "O"  
            puts "You can't do that it's Os turn"
          end
        elsif production.game.board[(self.id).to_i] =="O"
          if production.game.current_turn == "O"
            puts "An O was pulled"
            puts ""
            production.pull_position = (self.id).to_i
          elsif production.game.current_turn == "X"  
            puts "You can't do that it's Xs turn"
          end
        else
          puts "A blank piece was pulled"
          puts ""
          production.pull_position = (self.id).to_i         
        end
      end
    elsif place.legal_push_position(production.pull_position, (self.id).to_i) 
      production.push_position = (self.id).to_i
      self.text = production.game.current_turn
      production.game.shift_board(production.pull_position, production.push_position, self.text)
      production.game.board[production.push_position] = self.text
      production.pull_position = nil
      production.game.change_turn
            
      production.game.victory?("O")
      production.game.victory?("X")   
      
      # puts "Row 1: #{production.game.board[0]}, #{production.game.board[1]}, #{production.game.board[2]}, #{production.game.board[3]}, #{production.game.board[4]}"
      # puts "Row 2: #{production.game.board[5]}, #{production.game.board[6]}, #{production.game.board[7]}, #{production.game.board[8]}, #{production.game.board[9]}"
      # puts "Row 3: #{production.game.board[10]}, #{production.game.board[11]}, #{production.game.board[12]}, #{production.game.board[13]}, #{production.game.board[14]}"
      # puts "Row 4: #{production.game.board[15]}, #{production.game.board[16]}, #{production.game.board[17]}, #{production.game.board[18]}, #{production.game.board[19]}"
      # puts "Row 5: #{production.game.board[20]}, #{production.game.board[21]}, #{production.game.board[22]}, #{production.game.board[23]}, #{production.game.board[24]}"
      # puts ""      
    
      board.update
      puts "Its Now #{production.game.current_turn}'s Turn"
    end


    
    # if self.text == ""
    #   if production.game.current_turn == "X"
    #     self.text = "X" 
    #     production.game.change_turn
    #   elsif production.game.current_turn == "O"
    #     self.text = "O"
    #     production.game.change_turn
    #   end
    # end
  
  
  end
  
 #    place = Placement.new
 # 
 #     puts "turn: #{production.game.current_turn}"
 #   
 # 
 #     if production.pull_position == nil
 #       if place.legal_pull_position((self.id).to_i)
 #         production.pull_position = (self.id).to_i
 #       end
 #       
 #     elsif place.legal_push_position(production.pull_position, (self.id).to_i)
 #       production.push_position = (self.id).to_i     
 #       
 #       puts "pull #{production.pull_position}"
 #       puts "pull piece #{production.game.board[production.pull_position]}"
 #       puts "current_turn #{production.game.current_turn}"
 #       
 #       if production.game.board[production.pull_position] == "X" && production.game.current_turn == "X"
 #         puts "X pull"
 #         self.text = "X"
 #         production.game.board[production.pull_position] = ""
 # #       production.game.board[production.push_position] = "X"
 #         production.game.shift_board(production.pull_position, production.push_position, "X")
 #         production.game.change_turn 
 #       elsif production.game.board[production.pull_position] == "O" && production.game.current_turn == "O"
 #         puts "O pull"
 #         self.text = "O"
 #         production.game.board[production.pull_position] = ""        
 #  #      production.game.board[production.push_position] = "O" 
 #         production.game.shift_board(production.pull_position, production.push_position, "O")
 #         production.game.change_turn 
 #       elsif production.game.board[production.pull_position] == "" #self.text == ""
 #         puts "blank pull"
 #         self.text = production.game.current_turn
 #         production.game.board[production.pull_position] = ""
 #         production.game.shift_board(production.pull_position, production.push_position, production.game.current_turn) 
 #         production.game.change_turn     
 #       end
 #       
 #       
 #       # if production.game.board[production.pull_position] == "X" && production.game.board[production.push_position] == "O"
 #       #   production.game.board[production.push_position] = ""
 #       #   self.text = ""
 #       # elsif production.game.board[production.pull_position] == "O" && production.game.board[production.push_position] == "X"
 #       #   production.game.board[production.push_position] = ""
 #       #   self.text = ""
 #       # end  
 #       
 #       puts "push #{production.push_position}"
 #       puts "push piece #{production.game.board[production.push_position]}"      
 #             
 #       # production.game.change_turn      
 #             
 #       # if text == "" && production.game.current_turn == "X"
 #       #   self.text = "X"
 #       #   production.game.change_turn("O")
 #       # elsif text == "" && production.game.current_turn == "O"
 #       #   self.text = "O"
 #       #   production.game.change_turn("X")
 #       # end  
 #       
 #       puts "#{production.game.board}"
 #       production.game.board[(self.id).to_i] = self.text
 #       puts "#{production.game.board}"
 #       
 #       if production.game.current_turn == "X"
 #         production.game.victory?("O")
 #       elsif production.game.current_turn == "O" 
 #         production.game.victory?("X")   
 #       end
 #               
 #       production.pull_position = nil
 #     end
    
    #board.update
 # end   
end

