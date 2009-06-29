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
         game_piece = scene.find("0")
         puts "#{game_piece.style.background_color}"
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
     
     else
       if production.pull_position != nil
         production.push_position = (self.id).to_i
         if production.pull_position == production.push_position
           undo_move
         else
           status_bar.text = "Illegal Push Position"
         end
       end  
       
     end   
  end
  
  
private #########################
  
  def undo_move
    status_bar = scene.find("status_bar")
    self.style.background_color = "tan"
    self.style.text_color = "#004358"
    board.update
    production.pull_position = nil
    status_bar.text = "Piece Returned"
  end
  
  def select_piece
    status_bar = scene.find("status_bar")
    
    if production.game.board[(self.id).to_i] == "X"
      if production.game.current_turn == "X"
        status_bar.text = "An X Was Pulled"
        pull_piece
      elsif production.game.current_turn == "O"  
        status_bar.text = "Invalid Move"
      end
    elsif production.game.board[(self.id).to_i] =="O"
      if production.game.current_turn == "O"
        status_bar.text = "An O Was Pulled"
        pull_piece
      elsif production.game.current_turn == "X"  
        status_bar.text = "Invalid Move"
      end
    else
      status_bar.text = "Blank Piece Pulled"
      pull_piece 
    end
  end
  
  def pull_piece
    production.pull_position = (self.id).to_i
    self.style.background_color = "#004358"
    self.style.text_color = "tan"
  end
  
  def shift
    status_bar = scene.find("status_bar")
    self.text = production.game.current_turn
    status_bar.text = "Piece Placed"
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
      board.update
      scene.load("victory")
    elsif production.game.victory?("X")
      if production.player1 == ""
        status_bar.text = "Player 1 Wins!"
      else
        status_bar.text = "#{production.player1} Wins!"
      end
      board.update
      scene.load("victory")
    end    
  end
  
  def change_turn
    turn_bar = scene.find("turn_bar") 
    p1 = scene.find("p1")
    p2 = scene.find("p2")
    
    if production.game.current_turn == "X"
      p1.style.background_color = 'teal'
      p2.style.background_color = 'tan'
      if production.player1 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else          
        turn_bar.text = "It's #{production.player1}'s Turn"
      end
    else
      p1.style.background_color = 'tan'
      p2.style.background_color = 'teal'
      if production.player2 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else
        turn_bar.text = "It's #{production.player2}'s Turn"
      end
    end
  end
  
end
 