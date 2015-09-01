# require_relative './piece.rb'

class Queen < Piece
  DELTAS = [[0, 1], [0, -1], [1, 0], [-1, 0]] + [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  include Slidable

  def initialize(color, pos, board)
    # starting_pos [7, 3] [0, 3]
    super(color, pos, board)
    @value = "\u265B "
  end

  def deltas
    DELTAS
  end
end
