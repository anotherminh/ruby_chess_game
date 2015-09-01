# require './piece'

class Bishop < Piece
  DELTAS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  include Slidable

  #start  [[0, 2], [7, 2], [0, 5], [7, 5]]

  def initialize(color, pos, board)
    super(color, pos, board)
    @value = "\u265D "
  end

  def deltas
    DELTAS
  end
end
