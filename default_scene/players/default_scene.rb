module DefaultScene
  def scene_opened(event)
    production.turn = Turn.new
    production.count = 0
  end
end