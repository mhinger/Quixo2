# This file (production.rb) configures the production. It is the first file loaded when production is opened.

# The name of the production.  If not present, the production's name will default to the name of the root directory.
name "Quixo2"

# Attributes.  Defining attributes on the production will create getters/setters on the production object.
# Create attributes for any model objects or resources that need to accessible to props or players within the production

#attribute :attribute_name
  attribute :pull_position
  attribute :push_position
  attribute :game
  attribute :player1
  attribute :player2
  attribute :game_length_min
  attribute :player1_turns
  attribute :player2_turns
  attribute :player1_min
  attribute :player1_sec
  attribute :player2_min
  attribute :player2_sec
  attribute :stop_time
  attribute :start_time
  attribute :new_game
  attribute :timed_game
  attribute :animation
  attribute :game_type
  attribute :timer_started
  attribute :comp_player
  attribute :player1_wins
  attribute :player2_wins
  attribute :comp_pull