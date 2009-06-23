require "game"

module StartUp
  prop_reader :player1
  prop_reader :player2
  
  def button_pressed(event)
    text1 = player1.text
    puts "Player1: #{text1}"
    text2 = player2.text
    puts "Player2: #{text2}"
    scene.load("default_scene")
  end
  
end