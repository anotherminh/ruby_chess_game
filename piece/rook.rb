# require './piece'

class Rook < Piece
  DELTAS = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  include Slidable

  #starting pos: [[0, 0], [7, 0], [0, 7], [7, 7]]

  def initialize(color, pos, board)
    super(color, pos, board)
    @value = "\u265C "
  end

  def deltas
    DELTAS
  end
end
