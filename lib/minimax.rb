require "game"
require "ai"
class Minimax
  
  def initialize
    @game = Game.new
    @ai = Ai.new
  end
 
  def minimax(tree,lvl,total_levels)
    if lvl == total_levels - 1
      return tree
    elsif lvl % 2 == 0
      if tree.length == 2
        return [minimax(tree[0],lvl+1,total_levels),minimax(tree[1],lvl+1,total_levels)].max
      else
        return [minimax(tree[0],lvl+1,total_levels),minimax(tree[1],lvl+1,total_levels),minimax(tree[2],lvl+1,total_levels)].max 
      end
    # elsif lvl == 2
    #   return [minimax(tree[0],lvl+1),minimax(tree[1],lvl+1),minimax(tree[2],lvl+1)].max 
    elsif lvl % 2 == 1 
      return [minimax(tree[0],lvl+1,total_levels),minimax(tree[1],lvl+1,total_levels)].min
    end
  end
  
  #At the start, alpha is most neg num, beta is most pos num. This represents worst possible situation
  def alpha_beta(tree,lvl,alpha,beta,total_levels)     
    if lvl == total_levels - 1
          return tree
        end    
        if lvl % 2 == 0
          (tree.length).times do |i|
            score = alpha_beta(tree[i],lvl+1,alpha,beta,total_levels)
            if score > alpha
              alpha = score
            end
            if alpha >= beta
              return alpha
            end
          end
          return alpha
        elsif lvl % 2 == 1
          (tree.length).times do |i|
            score = alpha_beta(tree[i],lvl+1,alpha,beta,total_levels)
            if score < beta
              beta = score
            end
            if alpha >= beta
              return beta
            end
          end
          return beta
        end    
  end
  
  def evaluate_board(board)
    @ai.set_current_board(board)
    movements = get_locations(board)
    push_pull_score = []
    pos = 0
    (movements.size).times do |i|
      (movements[i][1].size).times do |j|
        push_pull_score[pos] = [movements[i][0],movements[i][1][j],0]
        pos = pos + 1
      end
    end
    return push_pull_score
  end
  
  def evaluate_possible_moves(board,mark)
    temp_board = board.clone
    possible_boards = []
    push_pull_score = evaluate_board(temp_board)
    pos = 0    
    (push_pull_score.size).times do |i|
      new_board = shift_board(push_pull_score[i][0],push_pull_score[i][1],mark,temp_board)
      possible_boards[pos] = new_board.clone
      pos = pos + 1
    end
    (possible_boards.size).times do |i|
      push_pull_score[i][2] = score_for(possible_boards[i],mark)
    end    
    scores = []
    (push_pull_score.size).times do |i|
      scores[i] = push_pull_score[i][2]
    end
    best_move = find_best_move(push_pull_score,scores)
    return best_move
  end
  
  def find_best_move(push_pull_score, scores)
    # alpha_beta(tree,lvl,alpha,beta,total_levels)  
    max_score = alpha_beta(scores,0,-10000000000000000000,10000000000000000000,2)  
    ###best move has the push pull and score in an array [push, pull, score]
    best_move = nil
    possible_good_moves = []
    pos = 0
    (push_pull_score.size).times do |i|
      if push_pull_score[i][2] == max_score
        possible_good_moves[pos] = push_pull_score[i].clone
        pos = pos + 1
      end
    end
    best_move = possible_good_moves[rand(possible_good_moves.size)]  
    return best_move 
  end
  
  def score_for(board, mark)
    score = five_in_a_line(board, mark) * 10000000000000000 +
            four_in_a_line(board, mark) * 10000 +
            three_in_a_line(board, mark) * 100 +
            two_in_a_line(board, mark) * 5 +
            corner_pieces(board, mark) * 4 
    score = score - five_in_a_line(board, "X") * 10000000000000000 -
            four_in_a_line(board, "X") * 10000 -
            three_in_a_line(board, "X") * 100 -
            two_in_a_line(board, "X") * 5 -
            corner_pieces(board, "X") * 4                    
    return score
  end
  
  def five_in_a_line(board, mark)
    rows_cols_diags_with_five = in_a_line(board,mark,5)  
    return rows_cols_diags_with_five
  end
  
  def four_in_a_line(board, mark)
    rows_cols_diags_with_four = in_a_line(board,mark,4)
    return rows_cols_diags_with_four
  end

  def three_in_a_line(board, mark)
    rows_cols_diags_with_three = in_a_line(board,mark,3)
    return rows_cols_diags_with_three
  end
  
  def two_in_a_line(board, mark)
    rows_cols_diags_with_two = in_a_line(board,mark,2)
    return rows_cols_diags_with_two
  end
  
  def corner_pieces(board, mark)
    corners = 0
    if board[0] == mark
      corners = corners + 1
    end
    if board[4] == mark
      corners = corners + 1
    end
    if board[20] == mark
      corners = corners + 1
    end
    if board[24] == mark
      corners = corners + 1
    end
    return corners
  end
  
  def in_a_line(board,mark,num)
    rows_with_num = row_line(board,mark,num)
    cols_with_num = col_line(board,mark,num)
    diag_with_num = diag_line(board,mark,num)
    return rows_with_num + cols_with_num + diag_with_num 
  end
  
  def row_line(board,mark,num)
    count = 0
    rows_with_num = 0
    5.times do |i|
      5.times do |j|
        if board[5 * i + j] == mark
          count = count + 1
        end
      end
      if count == num
        rows_with_num = rows_with_num + 1
      end
      count = 0
    end
    return rows_with_num
  end
  
  def col_line(board,mark,num)
    count = 0
    cols_with_num = 0
    5.times do |i|
      5.times do |j|
        if board[i + j * 5] == mark
          count = count + 1
        end
      end
      if count == num
        cols_with_num = cols_with_num + 1
      end
      count = 0
    end
    return cols_with_num
  end
  
  def diag_line(board,mark,num)
    count = 0
    diag_with_num = 0
    5.times do |i|
      if board[6 * i] == mark
        count = count + 1
      end
    end
    if count == num
      diag_with_num = diag_with_num + 1
    end
    count = 0
    5.times do |i|
      if board[4 * (i + 1)] == mark
        count = count + 1
      end
    end  
    if count == num
      diag_with_num = diag_with_num + 1
    end
    return diag_with_num
  end
  
  def get_locations(board)
    locations = []
    pos = 0
    moves = @ai.open_moves(board)
    25.times do |i|
      if moves[i] == true
        locations[pos] = i
        pos = pos + 1
      end
    end
    
    push_pulls = []
    (locations.size).times do |i|
      push_pulls[i] = [locations[i],get_legal_moves(locations[i])]
    end    
    return push_pulls.clone      
  end
  
  def get_legal_moves(locations)
    legal_moves = @ai.legal_moves(locations)
    return legal_moves.clone
  end
 
  def shift_board(pull,push,mark,board)
    game_board = @game.board_shift(pull,push,mark,board)
    return game_board.clone
  end
 
 
 
  def find_consecutive_pieces(board,mark)
     puts ""
     25.times do |i|
       if board[i] == ""
         board[i] = " "
       end
     end
     @ai.print_board(board)
     rows = [0,0,0,0,0]
     cols = [0,0,0,0,0]
     diags = [0,0]
     25.times do |i|
       row = i / 5
       col = i % 5
       if board[i]== mark
         rows[row] = rows[row] + 1
         cols[col] = cols[col] + 1
       end
     end 
     5.times do |i|
       if board[i * 6] == mark
         diags[0] = diags[0] + 1
       elsif board[i * 4 + 4] == mark
         diags[1] = diags[1] + 1
       end
     end
     5.times do |i|
       if rows[i] > 2
         5.times do |j|
           puts board[5 * i + j]
         end
       end
     end
     return [rows,cols,diags]
   end
end