module AiSetDiff
  
  def mouse_clicked(event)
    unbeat_checked = scene.find('unbeat_checked')
    unbeat_unchecked = scene.find('unbeat_unchecked')
    hard_checked = scene.find('hard_checked')
    hard_unchecked = scene.find('hard_unchecked')
    easy_checked = scene.find('easy_checked')
    easy_unchecked = scene.find('easy_unchecked')    
    
    if id == "unbeat_unchecked"
      unbeat_checked.style.transparency = 0
      unbeat_checked.style.width = 15
      unbeat_unchecked.style.transparency = 100
      unbeat_unchecked.style.width = 0
      hard_checked.style.transparency = 100
      hard_checked.style.width = 0
      hard_unchecked.style.transparency = 0
      hard_unchecked.style.width = 14
      easy_checked.style.transparency = 100
      easy_checked.style.width = 0
      easy_unchecked.style.transparency = 0
      easy_unchecked.style.width = 14
      production.comp_difficulty = "unbeatable"
    elsif id == "hard_unchecked"
      unbeat_checked.style.transparency = 100
      unbeat_checked.style.width = 0
      unbeat_unchecked.style.transparency = 0
      unbeat_unchecked.style.width = 14
      hard_checked.style.transparency = 0
      hard_checked.style.width = 15
      hard_unchecked.style.transparency = 100
      hard_unchecked.style.width = 0
      easy_checked.style.transparency = 100
      easy_checked.style.width = 0
      easy_unchecked.style.transparency = 0
      easy_unchecked.style.width = 14
      production.comp_difficulty = "hard"
    elsif id == "easy_unchecked"
      unbeat_checked.style.transparency = 100
      unbeat_checked.style.width = 0
      unbeat_unchecked.style.transparency = 0
      unbeat_unchecked.style.width = 14
      hard_checked.style.transparency = 100
      hard_checked.style.width = 0
      hard_unchecked.style.transparency = 0
      hard_unchecked.style.width = 14
      easy_checked.style.transparency = 0
      easy_checked.style.width = 15
      easy_unchecked.style.transparency = 100
      easy_unchecked.style.width = 0
      production.comp_difficulty = "easy"
    elsif id == "unbeat_checked"
      unbeat_checked.style.transparency = 100
      unbeat_checked.style.width = 0
      unbeat_unchecked.style.transparency = 0
      unbeat_unchecked.style.width = 14   
      production.comp_difficulty = ""
    elsif id == "hard_checked"
      hard_checked.style.transparency = 100
      hard_checked.style.width = 0
      hard_unchecked.style.transparency = 0
      hard_unchecked.style.width = 14
      production.comp_difficulty = ""
    elsif id == "easy_checked"
      easy_checked.style.transparency = 100
      easy_checked.style.width = 0
      easy_unchecked.style.transparency = 0
      easy_unchecked.style.width = 14
      production.comp_difficulty = ""
    end
    
    
  end
  
  
end