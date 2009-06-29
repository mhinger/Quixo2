require "game"
require "placement"

module Pieces
  
  prop_reader :board
  
  def mouse_clicked(e)  
    
    place = Placement.new
    
    turn_bar = scene.find("turn_bar") 
    status_bar = scene.find("status_bar")  
        
    if production.pull_position == nil
       if place.legal_pull_position((self.id).to_i)
         select_piece
       else
         status_bar.text = "Illegal Pull Position"
       end  
     
     elsif place.legal_push_position(production.pull_position, (self.id).to_i) 
       production.push_position = (self.id).to_i
       shift
       check_victory
       board.update
       change_turn
     
     elsif production.pull_position != nil
       production.push_position = (self.id).to_i
       if production.pull_position == production.push_position
         self.style.background_color = "tan"
         self.style.text_color = "teal"
         board.update
         production.pull_position = nil
         status_bar.text = "Piece Returned"
       end  
       
     end   
  end
  
  
private #########################
  
  def select_piece
    status_bar = scene.find("status_bar")
    
    if production.game.board[(self.id).to_i] == "X"
      if production.game.current_turn == "X"
        status_bar.text = "An X was pulled"
        pull_piece
      elsif production.game.current_turn == "O"  
        status_bar.text = "Invalid Move"
      end
    elsif production.game.board[(self.id).to_i] =="O"
      if production.game.current_turn == "O"
        status_bar.text = "An O was pulled"
        pull_piece
      elsif production.game.current_turn == "X"  
        status_bar.text = "Invalid Move"
      end
    else
      status_bar.text = "Blank piece pulled"
      pull_piece 
    end
  end
  
  def pull_piece
    production.pull_position = (self.id).to_i
    self.style.background_color = "black"
    self.style.text_color = "black"
  end
  
  def shift
    self.text = production.game.current_turn
    production.game.shift_board(production.pull_position, production.push_position, self.text)
    production.game.board[production.push_position] = self.text
    production.pull_position = nil
    production.game.change_turn    
  end
  
  def check_victory
    status_bar = scene.find("status_bar")
    
    if production.game.victory?("O")
      if production.player2 == ""
        status_bar.text = "Player 2 Wins!"
      else
        status_bar.text = "#{production.player2} Wins!"
      end
      # scene.load("victory")
    elsif production.game.victory?("X")
      if production.player1 == ""
        status_bar.text = "Player 1 Wins!"
      else
        status_bar.text = "#{production.player1} Wins!"
      end
      # scene.load("victory")
    end    
  end
  
  def change_turn
    turn_bar = scene.find("turn_bar") 
    
    if production.game.current_turn == "X"
      if production.player1 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else          
        turn_bar.text = "It's #{production.player1}'s Turn"
      end
    else
      if production.player2 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else
        turn_bar.text = "It's #{production.player2}'s Turn"
      end
    end
  end
  
end
 