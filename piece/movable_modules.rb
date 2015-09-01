module Slidable
  def avail_moves
    valid_moves = []
    deltas.each do |delta|
      new_valid = [pos[0] + delta[0], pos[1] + delta[1]]
      # debugger
      while board.empty_square_on_board?(new_valid)
        valid_moves << new_valid
        new_valid = [new_valid[0] + delta[0], new_valid[1] + delta[1]]
      end

      if kill_move?(new_valid)
        # board.on_board?(new_valid) && board[new_valid].color != color
        valid_moves << new_valid
      end
    end
    valid_moves
  end
end

module Steppable
  def avail_moves
    valid_moves = []
    deltas.each do |delta|
      new_valid = [pos[0] + delta[0], pos[1] + delta[1]]

      if board.empty_square_on_board?(new_valid) || kill_move?(new_valid)
        # board.on_board?(new_valid) && board[new_valid].color != color
        valid_moves << new_valid
      end
    end
    valid_moves
  end
end
