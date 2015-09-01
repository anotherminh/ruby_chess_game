module HVSlidable
  def avail_moves(current_pos, board)
    row = current_pos[0]
    col = current_pos[1]
    moves = []

    (0..7).each do |other_i|
      moves.push([row, other_i]) unless other_i == row
      moves.push([other_i, col]) unless other_i == col
    end

    moves
  end
end

module DiagSlidable

end
