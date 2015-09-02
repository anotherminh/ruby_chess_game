require 'byebug'

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @value = "\u265F "
    @moved = false
    @deltas = color == :black ? [[1, 0], [2, 0]] : [[-1, 0], [-2, 0]]
  end

  def avail_moves
    forward = @deltas.map do |delta|
      pos.zip(delta).map { |arr| arr.inject(:+) }
    end
    forward + avail_kill_moves
  end

  def avail_kill_moves
    kill_deltas = color == :black ? [[1, 1], [1, -1]] : [[-1, -1], [-1, 1]]
    kill_deltas.map do |delta|
      pos.zip(delta).map { |arr| arr.inject(:+) }
    end.select { |pos| kill_move?(pos) }
  end

  # def kill_move?(pos)
  #   if board.on_board?(pos)
  #     return board.occupied?(pos) && board[pos].color != color
  #   end
  #   false
  # end

  def move
    unless moved?
      offset = @deltas.pop
      @moved = true
    end
  end

  def moved?
    @moved
  end
end
