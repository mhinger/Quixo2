require "game"

module DefaultScene
  prop_reader :board
  
  def scene_opened(event)
    production.pull_position = nil
    production.push_position = nil
    production.game = Game.new
    player1 = scene.find("player1")
    player2 = scene.find("player2")
    player1.text = production.player1
    player2.text = production.player2
    board.update
  end
end