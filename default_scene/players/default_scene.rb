require "game"

module DefaultScene
  prop_reader :board
  prop_reader :timer
  
  def scene_opened(event)
    production.pull_position = nil
    production.push_position = nil
    production.game = Game.new
    player1 = scene.find("player1")
    player2 = scene.find("player2")
    turn_bar = scene.find("turn_bar")
    player1.text = production.player1
    player2.text = production.player2
    if production.player1 == ""
      turn_bar.text = "It's #{production.game.current_turn}'s Turn"
    else
      turn_bar.text = "It's #{production.player1}'s Turn"
    end
    board.update
  end
end