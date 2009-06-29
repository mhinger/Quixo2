default_container {

  main_container {
    instrs :id => 'instrs', :text => "Here is how you play this game: "
    instrs2 :id => 'instrs2', :text => "The rules of Quixo are very simple. The game board is a 5x5 grid of cubes. Depending on the orientation, each cube may be showing either blank, an X, or an O. In turn, each payer may remove either a blank cube or one of their own cubes from the periphery of the board. If a blank cube was selected, the cube is turned so that it becomes the player's piece (either an X or an O). The player may then insert the piece somewhere along the periphery of the board such that the other cubes slide into the blank space once occupied by the cube that was removed. The resulting board is a complete 5x5 grid. The cube may not be placed directly back to the spot where it was removed. You will always have 2 possible ways to insert the new cube if it was removed from a corner, otherwise you will have 3 possible ways to insert the cube. The game is over when a player gets 5 in a row, either horizontally, vertically, or diagonally"
    buffer2
    button :id => 'back', :text => 'Back', :on_button_pressed => "scene.load('start_up')"
  }

}