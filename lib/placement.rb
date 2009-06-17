require "game"

class Placement
  
  def legal_pull_position(pos)
    if row_find(pos) == 0 || row_find(pos) == 4 || col_find(pos) == 0 || col_find(pos) == 4
      return true
    else
      return false
    end
  end
  
  def legal_push_position(orig_pos, new_pos)
    row = row_find(orig_pos)
    col = col_find(orig_pos)
        
    if legal_pull_position(orig_pos) 
      if row == 0
        if col == 0 && (new_pos == 4 || new_pos == 20)
          return true
        elsif col == 4 && (new_pos == 0 || new_pos == 24)
          return true
        elsif (new_pos == 0 || new_pos == 4 || new_pos == (orig_pos + 20))
          return true      
        end
        
      elsif row == 4
        if col == 0 && (new_pos == 24 || new_pos ==0)
          return true
        elsif col == 4 && (new_pos == 20 || new_pos == 4)
          return true
        elsif (new_pos == 20 || new_pos == 24 || new_pos == (orig_pos - 20))
          return true
        end
    
      elsif row >=1
        if col == 0 && (new_pos == 0 || new_pos == 20 || new_pos == (orig_pos + 4))
          return true
        elsif col == 4 && (new_pos == 4 || new_pos == 24 || new_pos == (orig_pos - 4))
          return true
        end
     
      end
      
    else
      return false
    end
  end
  
private ################
  
  def row_find(pos)
    return pos / 5
  end
  
  def col_find(pos)
    return pos % 5
  end
  
end