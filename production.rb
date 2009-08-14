module Production

# This file (production.rb) configures the production. It is the first file loaded when production is opened.

# The name of the production.  If not present, the production's name will default to the name of the root directory.
  def name 
    return "Quixo2"
  end
  
  def production_opening
    $: << File.expand_path(File.dirname(__FILE__) + "/lib")
  end

# Attributes.  Defining attributes on the production will create getters/setters on the production object.
# Create attributes for any model objects or resources that need to accessible to props or players within the production

  attr_accessor :pull_position
  attr_accessor :push_position
  attr_accessor :game
  attr_accessor :player1
  attr_accessor :player2
  attr_accessor :game_length_min
  attr_accessor :player1_turns
  attr_accessor :player2_turns
  attr_accessor :player1_min
  attr_accessor :player1_sec
  attr_accessor :player2_min
  attr_accessor :player2_sec
  attr_accessor :stop_time
  attr_accessor :start_time
  attr_accessor :new_game
  attr_accessor :timed_game
  attr_accessor :animation
  attr_accessor :game_type
  attr_accessor :timer_started
  attr_accessor :comp_player
  attr_accessor :player1_wins
  attr_accessor :player2_wins
  attr_accessor :comp_pull


end