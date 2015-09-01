require './piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { "  " } }
    populate_empty_squares
    populate_pieces
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def on_board?(pos)
    return false unless pos
    pos.all? { |coor| coor.between?(0, grid.size - 1) }
  end

  def populate_empty_squares
    grid.each_with_index do |row, i|
      row.map!.with_index do |cell, j|
        EmptySquare.new([i, j])
      end
    end
    true
  end

  def populate_pieces
    Piece.make_all_pieces(self).each do |piece|
      coor = piece.pos
      self[coor] = piece
    end
  end

  def occupied?(pos)
    return false unless pos
    self[pos].occupied?
  end

  def move_piece(from, to)
    # debugger
    piece = self[from]
    piece.pos = to
    self[from] = self[to]
    self[to] = piece
  end

  def valid_move?(pos)
    !occupied?(pos) && on_board?(pos)
  end

  def valid_selection?(pos)
    occupied?(pos) && on_board?(pos)
  end

  def inspect
    true
  end
end
