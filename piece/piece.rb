require 'byebug'
require 'colorize'
require_relative './movable_modules'

class Piece
  attr_reader :value, :color, :board
  attr_accessor :pos

  def initialize(color, pos, board)
    @value = nil
    @color = color
    @pos = pos
    @board = board
    @board[pos] = self
  end

  def dup(dup_board)
    # debuggerab
    self.class.new(color, pos.dup, dup_board)
  end

  def avail_moves(deltas)
    raise NotImplementedError
  end

  def kill_move?(pos)
    if board.on_board?(pos)
      return board.occupied?(pos) && board[pos].color != color
    end
    false
  end

  # def kill(pos)
  #   if kill_move?(pos)
  #
  #   end
  # end

  def occupied?
    true
  end

  def to_s
    value.colorize(color)
  end

  def move
  end
end

class EmptySquare < Piece
  def initialize(_, pos, board)
    super(:nope, pos, board)
    @value = '  '
  end

  def occupied?
    false
  end

  def avail_moves
    []
  end
end
