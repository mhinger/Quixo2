require "game"
require "ai"

module StatsScreen
  
  def scene_opened(e)
    win_msg = scene.find('win_msg')
    time = scene.find('time')
    turn = scene.find('turn')
    if production.game.winning_mark == "X"
      if production.player1 == ""
        win_msg.text = "Player 1 Wins!"
      else
        win_msg.text = "#{production.player1} Wins!"
      end
      turn.text = "In #{production.player1_turns} Turns"
    elsif production.game.winning_mark == "O"
      if production.player2 == ""
        win_msg.text = "Player 2 Wins"
      else
        win_msg.text = "#{production.player2} Wins!"
      end
      turn.text = "In #{production.player1_turns} Turns"
    end
    
    if production.timed_game == "Yes"
      if production.game.winning_mark == "X"
        min_elapsed = production.game_length_min - production.player1_min - 1
        sec_elapsed = 60 - production.player1_sec
        if sec_elapsed < 10
          time_elapsed = "Time Elapsed For Victory #{min_elapsed}:0#{sec_elapsed}"
        else
          time_elapsed = "Time Elapsed For Victory #{min_elapsed}:#{sec_elapsed}"
        end
        time.text = time_elapsed
      elsif production.game.winning_mark == "O"
        min_elapsed = production.game_length_min - production.player2_min - 1
        sec_elapsed = 60 - production.player2_sec
        if sec_elapsed < 10
          time_elapsed = "Time Elapsed For Victory #{min_elapsed}:0#{sec_elapsed}"
        else
          time_elapsed = "Time Elapsed For Victory #{min_elapsed}:#{sec_elapsed}"
        end
        time.text = time_elapsed
      else
        if production.player1_sec == 0 && production.player1_min == 0
          win_msg.text = "#{production.player2} Wins!"
          time.text = "#{production.player1} Ran Out Of Time"
        elsif production.player2_sec == 0 && production.player2_min == 0
          win_msg.text = "#{production.player1} Wins"
          time.text = "#{production.player2} Ran Out Of Time"
        end
      end
    end
  end

end