require './piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { "  " } }
    populate_empty_squares
    populate_pieces
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def on_board?(pos)
    pos[0] >= 0 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 8
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
    pos = [0, 4]
    self[*pos] = King.new(:white, pos)
  end

  def occupied?(pos)
    self[*pos].occupied?
  end

  def move_piece(from, to)
    piece = self[*from]
    piece.pos = to
    self[*from], self[*to] = self[*to], self[*from]
  end

  def inspect
    true
  end
end
