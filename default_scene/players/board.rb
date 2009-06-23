require "game"

module Board
  
  def update
    self.remove_all
    25.times do |i|
      self.text = production.game.board[i]
      self.build do
        pieces :id => i, :text => self.text
      end
    end    
  end  
  
end