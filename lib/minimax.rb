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
    pull_push_score = []
    pos = 0
    (movements.size).times do |i|
      (movements[i][1].size).times do |j|
        pull_push_score[pos] = [movements[i][0],movements[i][1][j],0]
        pos = pos + 1
      end
    end
    return pull_push_score
  end
  
  def evaluate_possible_moves(board,mark)
    temp_board = board.clone
    possible_boards = []
    pull_push_score = evaluate_board(temp_board.clone)
    pos = 0    
    (pull_push_score.size).times do |i|
      new_board = shift_board(pull_push_score[i][0],pull_push_score[i][1],mark,temp_board.clone)
      possible_boards[pos] = new_board.clone
      pos = pos + 1
    end
    (possible_boards.size).times do |i|
      pull_push_score[i][2] = score_for(possible_boards[i],mark)
      if four_in_a_line_win_opportunity(possible_boards[i],"X") == true
        pull_push_score[i][2] = pull_push_score[i][2] - 10000
      end
      if four_in_a_line_win_opportunity(possible_boards[i],"O") == true && four_in_a_line_win_opportunity(possible_boards[i],"X") == false
        pull_push_score[i][2] = pull_push_score[i][2] + 1000        
      end
    end  
      
    scores = []    
    (pull_push_score.size).times do |i|
      scores[i] = pull_push_score[i][2]
    end
    best_move = find_best_move(pull_push_score,scores)
    return best_move
  end
  
  def find_best_move(pull_push_score, scores)
    # alpha_beta(tree,lvl,alpha,beta,total_levels) 
    max_score = alpha_beta(scores,0,-1000000000000000000,1000000000000000000,2)  
    ###best move has the push pull and score in an array [pull, push, score]
    best_move = nil
    possible_good_moves = []
    pos = 0
    
    (pull_push_score.size).times do |i|
      if pull_push_score[i][2] == max_score
        possible_good_moves[pos] = pull_push_score[i].clone
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
            two_in_a_line(board, mark) * 10 +
            corner_pieces(board, mark) * 0.25
    if mark == "O"      
      score = score - five_in_a_line(board, "X") * 10000000000000000 -
              four_in_a_line(board, "X") * 10050 -
              three_in_a_line(board, "X") * 125 -
              two_in_a_line(board, "X") *  10 -
              corner_pieces(board, "X") * 0.25            
    elsif mark == "X"  
      score = score - five_in_a_line(board, "O") * 10000000000000000 -
              four_in_a_line(board, "O") * 10050 -
              three_in_a_line(board, "O") * 125 -
              two_in_a_line(board, "O") *  10 -
              corner_pieces(board, "O") * 0.25  
    end  
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
 
  def four_in_a_line_win_opportunity(board,mark)
    row_win_opportunity = row_line(board,mark,4)
    col_win_opportunity = col_line(board,mark,4)
    diag_win_opportunity = diag_line(board,mark,4)
    
    col = []
    diag = []
    count = 0
    winning_spot = nil
    
    if col_win_opportunity != 0
      5.times do |i|
        5.times do |j|
          if board[i + j * 5] == mark
            count = count + 1
          end
        end
        if count == 4
          col[i] = i
        end
        count = 0
      end
    end
        
    (col.size).times do |i|
      if col[i] != nil
        5.times do |j|
          if board[col[i] + j * 5] != mark
            row = (col[i] + j * 5) / 5
            # puts row
            # puts col[i]
            winning_pull = check_row_for_winning_move(board,row,col[i],mark)
            # puts "Col.size: Winning Pull: #{winning_pull}"
            if winning_pull != nil
              return true
            end
          end
        end
      end
    end
    
    row = []
    count = 0
    
    if row_win_opportunity != 0
      5.times do |i|
        5.times do |j|
          if board[i * 5 + j] == mark
            count = count + 1
          end
        end
        if count == 4
          row[i] = i
        end
        count = 0
      end
    end
    
    (row.size).times do |i|
      if row[i] != nil
        5.times do |j|
          if board[row[i] * 5 + j] != mark
            col = (row[i] * 5 + j) % 5
            winning_pull = check_col_for_winning_move(board,col,row[i],mark)
            # puts "Row.size: Winning Pull: #{winning_pull}"
            if winning_pull != nil
              return true
            end
          end
        end
      end
    end
    return false
  end

  def check_row_for_winning_move(board,row,win_col,mark)
    if row == 0 || row == 4
      5.times do |i|
        if board[row * 5 + i] == mark || board[row * 5 + i] == ""
          return row * 5 + i
        end
      end
    else
      if board[row * 5] == mark || board[row * 5] == ""
        return row * 5
      elsif board[row * 5 + 4] == mark || board[row * 5 + 4] == ""
        return row * 5 + 4
      end    
    end
    return nil
  end
  
  def check_col_for_winning_move(board,col,win_row,mark)
    if col == 0 || col == 4
      5.times do |i|
        if board[col + i * 5] == mark || board[col + i * 5] == ""
          return col + i * 5
        end
      end
    else
      if board[col] == mark || board[col] == ""
        return col
      elsif board[col + 20] == mark || board[col + 20] == ""
        return col + 20
      end
    end
    return nil
  end


end