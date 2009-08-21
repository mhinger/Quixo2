require "game"

module Board
  
  def update
    25.times do |i|
      text = production.game.board[i]
      child = children[0].children[i]
      child.text = text
      child.style.background_color = "#D99963"
      child.style.text_color = "black"
      if i / 5 == 0
        child.style.top_margin = 0
      elsif i /5 == 4
        child.style.bottom_margin = 0
      end
      if i % 5 == 0
        child.style.left_margin = 0
      elsif i % 5 == 4
        child.style.right_margin = 0
      end
    end    
  end  
  
end