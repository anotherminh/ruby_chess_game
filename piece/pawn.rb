# require_relative 'piece/piece'

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @value = "\u2659 "
  end

  def avail_moves
    []
  end
end
