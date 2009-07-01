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
        if production.timed_game == "Yes"
          if production.new_game == "Yes"
            timer_start
            production.new_game = "No"
          end
        end
        select_piece
        find_legal_moves
      else
        status_bar.text = "Illegal Pull Position"
      end  
     
    elsif place.legal_push_position(production.pull_position, (self.id).to_i)
      production.push_position = (self.id).to_i
      increment_turn
      shift
      check_victory
      board.update
      change_turn
      highlight_previous_move
      if production.timed_game == "Yes"  
        timer_stop(production.game.prev_turn)   
      end
      
    else
      if production.pull_position != nil
        if production.pull_position == (self.id).to_i
          undo_move
        else
          status_bar.text = "Illegal Push Position"
        end
      end  
      highlight_previous_move
    end   
  end
  
  
private #########################
  def timer_start
    production.start_time = Time.now
  end
  
  def timer_stop(turn)
    timer1 = scene.find("player1_timer")
    timer2 = scene.find("player2_timer")
    production.stop_time = Time.now
    diff = production.stop_time - production.start_time
    min = (diff / 60).to_i
    sec = (((diff / 60) - min) * 60).round
    if turn == "X"
      timer_start
      if production.player1_sec < sec
        production.player1_min = (production.player1_min - 1) - min
        production.player1_sec = (production.player1_sec + 60) - sec
      elsif (production.player1_sec - sec) >= 0
        production.player1_min = production.player1_min - min
        production.player1_sec = production.player1_sec - sec
      end
      if production.player1_sec < 10
        timer1.text = "#{production.player1_min}:0#{production.player1_sec}"
      else
        timer1.text = "#{production.player1_min}:#{production.player1_sec}"
      end

    elsif turn == "O"
      timer_start
      if production.player2_sec < sec
        production.player2_min = (production.player2_min - 1) - min
        production.player2_sec = (production.player2_sec + 60) - sec
      elsif (production.player2_sec - sec) >= 0
        production.player2_min = production.player2_min - min
        production.player2_sec = production.player2_sec - sec
      end
      if production.player2_sec < 10
        timer2.text = "#{production.player2_min}:0#{production.player2_sec}"
      else
        timer2.text = "#{production.player2_min}:#{production.player2_sec}"
      end
    end
  end

  def increment_turn
    if production.game.current_turn == "X"
      production.player1_turns = production.player1_turns + 1
    elsif production.game.current_turn == "O"
      production.player2_turns = production.player2_turns + 1
    end
  end

  def highlight_previous_move
    if production.game.prev_turn != ""
      pos = production.push_position
      game_piece = scene.find(pos)
      game_piece.style.background_color = "#CCFFFF"#"light_sky_blue"
    end
  end
  
  def find_legal_moves
    if production.pull_position != nil
      count = 0
      if production.pull_position == 0
        legals = [4,20]
      elsif production.pull_position == 1
        legals = [0, 4, 21]
      elsif production.pull_position == 2
        legals = [0, 4, 22]
      elsif production.pull_position == 3
        legals = [0, 4, 23]
      elsif production.pull_position == 4
        legals = [0, 24]  
      elsif production.pull_position == 5
        legals = [0, 9, 20]  
      elsif production.pull_position == 9
        legals = [4, 5, 24]  
      elsif production.pull_position == 10
        legals = [0, 14, 20]
      elsif production.pull_position == 14
        legals = [4, 10, 24]
      elsif production.pull_position == 15
        legals = [0, 19, 20]
      elsif production.pull_position == 19
        legals = [4, 15, 24]
      elsif production.pull_position == 20
        legals = [0, 24]
      elsif production.pull_position == 21
        legals = [1, 20, 24]
      elsif production.pull_position == 22
        legals = [2, 20, 24]
      elsif production.pull_position == 23
        legals = [3, 20, 24]
      elsif production.pull_position == 24
        legals = [4, 20]    
      end
      legals.each do
        count = count + 1
      end
      count.times do |i|
        pos = legals[i]
        game_piece = scene.find(pos)
        game_piece.style.background_color = "chartreuse"
      end
    end
  end
  
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
        status_bar.text = "Invalid Move. That Is Not Your Piece"
      end
    elsif production.game.board[(self.id).to_i] =="O"
      if production.game.current_turn == "O"
        status_bar.text = "An O Was Pulled"
        pull_piece
      elsif production.game.current_turn == "X"  
        status_bar.text = "Invalid Move. That Is Not Your Piece"
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
      puts "Player 1 Turns: #{production.player1_turns}"
      puts "Player 2 Turns: #{production.player2_turns}"      
      # scene.load("victory")
    elsif production.game.victory?("X")
      if production.player1 == ""
        status_bar.text = "Player 1 Wins!"
      else
        status_bar.text = "#{production.player1} Wins!"
      end
      board.update
      puts "Player 1 Turns: #{production.player1_turns}"
      puts "Player 2 Turns: #{production.player2_turns}"
      # scene.load("victory")
    end    
  end
  
  def change_turn
    timer1 = scene.find("player1_timer")
    timer2 = scene.find("player2_timer")
    turn_bar = scene.find("turn_bar") 
    p1 = scene.find("p1")
    p2 = scene.find("p2")
    
    if production.game.current_turn == "X"
      p1.style.background_color = 'teal'
      p2.style.background_color = 'tan'
      timer1.style.background_color = 'teal'
      timer2.style.background_color = 'tan'   
      if production.player1 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else          
        turn_bar.text = "It's #{production.player1}'s Turn"
      end
    else
      p1.style.background_color = 'tan'
      p2.style.background_color = 'teal'
      timer1.style.background_color = 'tan'
      timer2.style.background_color = 'teal'
      if production.player2 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else
        turn_bar.text = "It's #{production.player2}'s Turn"
      end
    end
  end
  
end