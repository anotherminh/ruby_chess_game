# require './piece'

class King < Piece
  DELTAS = [[0, 1], [0, -1], [1, 0], [-1, 0]] + [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  include Steppable

  def initialize(color, pos, board)
    # starting_pos [7, 3] [0, 3]
    super(color, pos, board)
    @value = "\u265A "
  end

  def deltas
    DELTAS
  end
end
