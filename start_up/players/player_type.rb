module PlayerType
  
  def mouse_clicked(e)
    if self.text == "AI Name: "
      if self.id == "p1"
        self.text = "Player 1 Name: "
      else
        self.text = "Player 2 Name: "
      end
      production.game_type = "Two Player Game"
    else
      self.text = "AI Name: "
      production.game_type = "One Player Game"
    end
  end
  
end