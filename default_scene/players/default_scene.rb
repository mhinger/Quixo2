require "game"

module DefaultScene
  prop_reader :board
  
  def scene_opened(event)
    production.pull_position = nil
    production.push_position = nil
    production.game = Game.new
    board.update
  end
end