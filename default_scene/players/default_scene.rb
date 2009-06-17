module DefaultScene
  def scene_opened(event)
    production.turn = Turn.new
    production.pull_position = nil
    production.push_position = nil
  end
end