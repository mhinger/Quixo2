require "game"
require "ai"

module DefaultScene
  prop_reader :board
  prop_reader :timer
  
  def scene_opened(event)
    production.pull_position = nil
    production.push_position = nil
    production.player1_turns = 0
    production.player2_turns = 0
    production.comp_pull = nil
    production.game = Game.new
    production.comp_player = Ai.new
    p1 = scene.find("p1")
    p2 = scene.find("p2")
    turn_bar = scene.find("turn_bar")
    p1.text = production.player1
    p2.text = production.player2
    p1.style.background_color = "teal"
    p2.style.background_color = "tan"
    timer1 = scene.find("player1_timer")
    timer2 = scene.find("player2_timer")
    production.new_game = "Yes"
    production.timer_started = "No"  
    if production.game_type == "One Player Game"
      production.timed_game = "No"
    end  
    
    if production.timed_game == "Yes"
      production.player1_min = production.game_length_min
      production.player2_min = production.game_length_min 
      production.player1_sec = 0
      production.player2_sec = 0 
      timer1.text = "#{production.player1_min}:00"
      timer2.text = "#{production.player2_min}:00"
    elsif production.timed_game == "No"
      timer1.style.transparency = 100
      timer2.style.transparency = 100
    end
    
    if production.player1 == ""
      turn_bar.text = "It's #{production.game.current_turn}'s Turn"
    else
      turn_bar.text = "It's #{production.player1}'s Turn"
    end    
    board.update
  end
  
end