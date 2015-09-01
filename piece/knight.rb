# require './piece'

class Knight < Piece
  DELTAS = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  include Steppable

  #starting_pos [[0, 1], [7, 1], [0, 6], [7, 6]]

  def initialize(color, pos, board)
    super(color, pos, board)
    @value = "\u265E "
  end

  def deltas
    DELTAS
  end
end
