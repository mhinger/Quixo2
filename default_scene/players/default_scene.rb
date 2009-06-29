require "game"

module DefaultScene
  prop_reader :board
  prop_reader :timer
  
  def scene_opened(event)
    production.pull_position = nil
    production.push_position = nil
    production.game = Game.new
    p1 = scene.find("p1")
    p2 = scene.find("p2")
    turn_bar = scene.find("turn_bar")
    p1.text = production.player1
    p2.text = production.player2
    p1.style.background_color = "teal"
    p2.style.background_color = "tan"
    if production.player1 == ""
      turn_bar.text = "It's #{production.game.current_turn}'s Turn"
    else
      turn_bar.text = "It's #{production.player1}'s Turn"
    end
    board.update
  end
end