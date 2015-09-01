require 'colorize'
require './movable_modules'

class Piece
  attr_reader :value, :color, :board
  attr_accessor :pos

  def initialize(val, color, pos = [0, 0], board)
    @value = val
    @color = color
    @pos = pos
    @board = board
  end

  def avail_moves(deltas)
    [[]]
  end

  def occupied?
    true
  end

  def to_s
    value.colorize(color)
  end

  def self.make_all_pieces(board)
    King.make_kings(board) +
    Queen.make_queens(board) +
    Bishop.make_bishops(board) +
    Rook.make_rooks(board) +
    Knight.make_knights(board) +
    Pawn.make_pawns(board)
  end
end

class EmptySquare < Piece
  def initialize(pos)
    super('  ', :empty, pos)
  end

  def occupied?
    false
  end

  def avail_moves
    [[]]
  end
end

class King < Piece
  DELTAS = [[0, 1], [0, -1], [1, 0], [-1, 0]] + [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  include Steppable

  def self.make_kings(board)
    [King.new(:white, board), King.new(:black, board)]
  end

  def initialize(color, pos = nil, board)
    pos ||= color == :white ? [7, 4] : [0, 4]
    super("\u2654 ", color, pos, board)
  end

  def deltas
    DELTAS
  end
end

class Queen < Piece
  DELTAS = [[0, 1], [0, -1], [1, 0], [-1, 0]] + [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  include Slidable

  def self.make_queens(board)
    [Queen.new(:white, board), Queen.new(:black, board)]
  end

  def initialize(color, pos = nil, board)
    pos ||= color == :white ? [7, 3] : [0, 3]
    super("\u2655 ", color, pos, board)
  end

  def deltas
    DELTAS
  end
end

class Rook < Piece
  DELTAS = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  include Slidable

  def self.make_rooks(board)
    [[0, 0], [7, 0], [0, 7], [7, 7]].map.with_index do |pos, i|
      color = i.odd? ? :white : :black
      Rook.new(color, pos, board)
    end
  end

  def initialize(color, pos, board)
    super("\u2656 ", color, pos, board)
  end

  def deltas
    DELTAS
  end
end

class Bishop < Piece
  DELTAS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  include Slidable

  def self.make_bishops(board)
    [[0, 2], [7, 2], [0, 5], [7, 5]].map.with_index do |pos, i|
      color = i.odd? ? :white : :black
      Bishop.new(color, pos, board)
    end
  end

  def initialize(color, pos, board)
    super("\u2657 ", color, pos, board)
  end

  def deltas
    DELTAS
  end
end

class Knight < Piece
  DELTAS = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  include Steppable

  def self.make_knights(board)
    [[0, 1], [7, 1], [0, 6], [7, 6]].map.with_index do |pos, i|
      color = i.odd? ? :white : :black
      Knight.new(color, pos, board)
    end
  end

  def initialize(color, pos, board)
    super("\u2658 ", color, pos, board)
  end

  def deltas
    DELTAS
  end
end

class Pawn < Piece
  def self.make_pawns(board)
    pawns = []
    [1, 6].each do |row_i|
      (0..7).to_a.each do |cell_i|
        color = row_i == 1 ? :black : :white
        pawns << Pawn.new(color, [row_i, cell_i], board)
      end
    end
    pawns
  end

  def initialize(color, pos, board)
    super("\u2659 ", color, pos, board)
  end

  def avail_moves
    [[]]
  end
end
