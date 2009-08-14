require "game"

module Board
  
  def update
    # self.remove_all
    25.times do |i|
      text = production.game.board[i]
      children[i].text = text
      children[i].style.background_color = "tan"
      children[i].style.text_color = "#004358"
      # self.build do
      #         # if i == 24
      #         #   pieces :id => i, :text => text, :players => "pieces image", :image => "24.png", :scaled => true
      #         # elsif i == 23
      #         #   pieces :id => i, :text => text, :players => "pieces image", :image => "23.png", :scaled => true
      #         # elsif i == 22
      #         #   pieces :id => i, :text => text, :players => "pieces image", :image => "22.png", :scaled => true
      #         # elsif i == 21
      #         #   pieces :id => i, :text => text, :players => "pieces image", :image => "21.png", :scaled => true
      #         # elsif i == 20
      #         #   pieces :id => i, :text => text, :players => "pieces image", :image => "20.png", :scaled => true
      #         # else
      #           pieces :id => i, :text => text   #, :players => "pieces image", :image => "3dquixov2 copy.png", :scaled => true
      #         # end
      # end
    end    
  end  
  
end