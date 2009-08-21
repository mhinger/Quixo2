require "game"
require "placement"
require "minimax"
require "ai"

module Pieces
  
  prop_reader :board
  prop_reader :victory
  
  def mouse_clicked(e)          
    place = Placement.new
    turn_bar = scene.find("turn_bar") 
    status_bar = scene.find("status_bar")
###Human vs Human
    if production.game_type == "Two Player Game"   
      if production.pull_position == nil 
        pulling_of_piece(place,status_bar)    
      elsif place.legal_push_position(production.pull_position, (self.id).to_i)
        pushing_of_piece
      else
        check_for_undo(status_bar)
      end   
###Human vs AI
    elsif production.game_type == "One Player Game"            
      if production.pull_position == nil           
        if production.game.current_turn == "X"
          pulling_of_piece(place,status_bar)
        end         
      elsif place.legal_push_position(production.pull_position, (self.id).to_i) && production.game.current_turn == "X"     
        production.comp_player.set_prev_board(production.game.board)     
        pushing_of_piece
        check_victory
        production.comp_player.set_current_board(production.game.board)
        if check_victory == false
          make_computer_move(place)  
        end
        check_victory    
      else
        check_for_undo(status_bar)
      end
    end   
  end
    
private #########################
  def make_computer_move(place)
    minmax = Minimax.new
    best_move = []
    status_bar = scene.find("status_bar")
    best_move = minmax.evaluate_possible_moves(production.game.board,"O",production.comp_difficulty)
    computer_pull_piece(place,best_move[0])
    delay
    computer_push_piece(status_bar,place,best_move[1])
    highlight_comp_pull
    check_victory
  end

  def delay
    5000000.times do 
    end    
  end

  def computer_pull_piece(place,pull)
    pull_pos = pull
    game_piece = scene.find(pull)
    game_piece.style.background_color = "#5E0900"#"black"
    game_piece.style.text_color = "tan"
    if place.legal_pull_position(pull_pos) && pull_pos != nil
      if production.game.board[pull_pos] == "O"
        production.pull_position = pull_pos
      elsif production.game.board[pull_pos] == nil
        production.pull_position = pull_pos
      end 
    end 
    production.comp_pull = production.pull_position
  end

  def computer_push_piece(status_bar,place,push)
    push_pos = push
    if place.legal_push_position(production.pull_position, push_pos)
      production.push_position = push_pos
      increment_turn
      status_bar.text = "Piece Placed"
      production.game.shift_board(production.pull_position, production.push_position, "O")
      production.game.board[production.push_position] = "O"
      production.pull_position = nil
      production.game.change_turn
      check_victory
      board.update          
      change_turn
      highlight_previous_move
    end
  end

  def check_for_undo(status_bar)
    if production.pull_position != nil
      if production.pull_position == (self.id).to_i
        undo_move
      else
        status_bar.text = "Illegal Push Position"
      end
    end  
    highlight_previous_move
  end
  
  def pushing_of_piece
    production.push_position = (self.id).to_i
    increment_turn
    shift
    check_victory
    board.update
    change_turn
    highlight_previous_move
  end

  def pulling_of_piece(place,status_bar)
    if place.legal_pull_position((self.id).to_i)
      if production.game_type == "Two Player Game"
        timer_config
      end
      select_piece
      find_legal_moves
    else
      status_bar.text = "Illegal Pull Position"
    end
  end
  
  def timer_config
    if production.timed_game == "Yes" && production.new_game == "Yes"
      production.timer_started = "Yes"
      timer_start
      production.new_game = "No"
    end
  end

  def timer_start
    status_bar = scene.find("status_bar")
    no_time = scene.find("no_time")
    stats_button = scene.find('stats')
    production.player1_sec = 60
    production.player1_min = production.game_length_min - 1
    production.player2_sec = 60
    production.player2_min = production.game_length_min - 1
    production.animation = animate(:updates_per_second => 1) do
      if production.game.current_turn == "X"
        timer1 = scene.find("player1_timer")
        if production.player1_sec == 0
          production.player1_min = production.player1_min - 1
          production.player1_sec = 60
        end
        production.player1_sec = production.player1_sec - 1
        if production.player1_sec >= 10
          timer1.text = "#{production.player1_min}:#{production.player1_sec}"
        elsif production.player1_sec >= 0
          timer1.text = "#{production.player1_min}:0#{production.player1_sec}"
        end
        if production.player1_sec == 0 && production.player1_min == 0
          status_bar.text = "#{production.player2} Wins, #{production.player1} Ran Out Of Time"
          production.animation.stop 
          stats_button.style.width = 90
          stats_button.style.height = 25
          no_time.style.width = 354
          no_time.style.height = 354
        end
      elsif production.game.current_turn == "O"
        timer2 = scene.find("player2_timer")
        if production.player2_sec == 0
          production.player2_min = production.player2_min - 1
          production.player2_sec = 60
        end
        production.player2_sec = production.player2_sec - 1
        if production.player2_sec >= 10
          timer2.text = "#{production.player2_min}:#{production.player2_sec}"
        elsif production.player2_sec >= 0
          timer2.text = "#{production.player2_min}:0#{production.player2_sec}"
        end
        if production.player2_sec == 0 && production.player2_min == 0
          status_bar.text = "#{production.player1} Wins, #{production.player2} Ran Out Of Time"
          production.animation.stop 
          stats_button.style.width = 90
          stats_button.style.height = 25
          no_time.style.width = 354
          no_time.style.height = 354      
        end        
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

  def highlight_comp_pull
    pos = production.comp_pull
    game_piece = scene.find(pos)
    game_piece.style.background_color = "#004358"
    game_piece.style.text_color = "tan"
  end

  def highlight_previous_move
    if production.game.prev_turn != ""
      pos = production.push_position
      game_piece = scene.find(pos)
      game_piece.style.background_color = "#CCFFFF"
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
    self.style.background_color = "#5E0900"#"black"#"#004358"
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
      if production.timed_game == "Yes"
        production.animation.stop
      end
      if production.player2 == ""
        status_bar.text = "Player 2 Wins!"
      else
        status_bar.text = "#{production.player2} Wins!"
      end
      strike_victory
      board.update 
      return true
    elsif production.game.victory?("X")
      if production.timed_game == "Yes"
        production.animation.stop
      end
      if production.player1 == ""
        status_bar.text = "Player 1 Wins!"
      else
        status_bar.text = "#{production.player1} Wins!"
      end
      strike_victory
      board.update
      return true
    end 
    return false   
  end
  
  def strike_victory
    stats_button = scene.find('stats')
    stats_button.style.width = 90
    stats_button.style.height = 25
    strike = scene.find("strike_through")
    strike.style.transparency = 20
    strike.style.width = 354
    strike.style.height = 354
    
    if production.game.win_row == 0
      strike.style.top_padding = 30
      strike.style.left_padding = 2
      strike.style.right_padding = 2
      strike.rotation = 0
    elsif production.game.win_row == 1
      strike.style.top_padding = 100
      strike.style.left_padding = 2
      strike.style.right_padding = 2
      strike.rotation = 0
    elsif production.game.win_row == 2
      strike.style.top_padding = 170
      strike.style.left_padding = 2
      strike.style.right_padding = 2
      strike.rotation = 0
    elsif production.game.win_row == 3
      strike.style.top_padding = 240
      strike.style.left_padding = 2
      strike.style.right_padding = 2
      strike.rotation = 0
    elsif production.game.win_row == 4
      strike.style.top_padding = 310
      strike.style.left_padding = 2
      strike.style.right_padding = 2
      strike.rotation = 0
    elsif production.game.win_col == 0
      strike.style.top_padding = 2
      strike.style.left_padding = 30
      strike.style.bottom_padding = 2
      strike.rotation = 90
    elsif production.game.win_col == 1
      strike.style.top_padding = 2
      strike.style.left_padding = 100
      strike.style.bottom_padding = 2  
      strike.rotation = 90    
    elsif production.game.win_col == 2
      strike.style.top_padding = 2
      strike.style.left_padding = 170
      strike.style.bottom_padding = 2
      strike.rotation = 90
    elsif production.game.win_col == 3
      strike.style.top_padding = 2
      strike.style.left_padding = 240
      strike.style.bottom_padding = 2
      strike.rotation = 90
    elsif production.game.win_col == 4
      strike.style.top_padding = 2
      strike.style.left_padding = 310
      strike.style.bottom_padding = 2
      strike.rotation = 90
    elsif production.game.diag_win == "down_right"
      strike.style.padding = 4
      strike.rotation = 45
    elsif production.game.diag_win == "up_right"
      strike.style.left_padding = 4
      strike.style.top_padding = 4
      strike.rotation = 135
    end
  end
  
  def change_turn
    timer1 = scene.find("player1_timer")
    timer2 = scene.find("player2_timer")
    turn_bar = scene.find("turn_bar") 
    p1 = scene.find("p1")
    p2 = scene.find("p2") 
    if production.game.current_turn == "X"
      p1.style.background_color = "#CCFFFF"#'teal'
      p2.style.background_color = "#D99963"#'tan'
      if production.player1 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else          
        turn_bar.text = "It's #{production.player1}'s Turn"
      end
    else
      p1.style.background_color = "#D99963"#'tan'
      p2.style.background_color = "#CCFFFF"#'teal'
      if production.player2 == ""
        turn_bar.text = "It's #{production.game.current_turn}'s Turn"
      else
        turn_bar.text = "It's #{production.player2}'s Turn"
      end
    end
  end
  
end