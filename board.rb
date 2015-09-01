require_relative 'piece/piece'
require_relative 'piece/knight'
require_relative 'piece/queen'
require_relative 'piece/king'
require_relative 'piece/bishop'
require_relative 'piece/rook'
require_relative 'piece/pawn'

class Board
  attr_reader :grid

  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) { "  " } }
    if setup
      populate_empty_squares
      populate_pieces
    else
      populate_empty_squares
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    mark.pos = pos
    @grid[row][col] = mark
  end

  def on_board?(pos)
    return false unless pos
    pos.all? { |coor| coor.between?(0, grid.size - 1) }
  end

  def populate_empty_squares
    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        EmptySquare.new(:nope, [i, j], self)
      end
    end
    true
  end

  def populate_pieces
    King.new(:white, [7, 4], self)
    King.new(:black, [0, 4], self)
    Queen.new(:white, [7, 3], self)
    Queen.new(:black, [0, 3], self)
    [[7, 2], [7, 5]].each { |pos| Bishop.new(:white, pos, self) }
    [[0, 2], [0, 5]].each { |pos| Bishop.new(:black, pos, self) }
    [[7, 1], [7, 6]].each { |pos| Knight.new(:white, pos, self) }
    [[0, 1], [0, 6]].each { |pos| Knight.new(:black, pos, self) }
    [[7, 7], [7, 0]].each { |pos| Rook.new(:white, pos, self) }
    [[0, 7], [0, 0]].each { |pos| Rook.new(:black, pos, self) }
    [1, 6].each do |row_i|
      color = row_i == 1 ? :black : :white
      (0..7).to_a.each do |cell_i|
        Pawn.new(color, [row_i, cell_i], self)
      end
    end
  end

  def occupied?(pos)
    return false unless pos
    self[pos].occupied?
  end

  def move_piece(from, to)
    if self[from].kill_move?(to)
      # kill!!!
      self[to] = self[from]
      self[from] = EmptySquare.new(:nope, from, self)
    else
      self[from], self[to] = self[to], self[from]
    end
  end

  def empty_square_on_board?(pos)
    on_board?(pos) && !occupied?(pos)
  end

  def valid_selection?(pos)
    on_board?(pos) && occupied?(pos)
  end

  def avail_moves(pos)
    self[pos].avail_moves
  end

  def valid_moves(color, cursor_pos)
    valid_moves = []
    avail_moves(cursor_pos).each do |next_move|
      dup_board = self.dup
      dup_board.move_piece(cursor_pos, next_move)
      valid_moves << next_move unless dup_board.in_check?(color)
    end
    valid_moves
  end

  def find_king(color)
    king = @grid.flatten.find do |piece|
      piece.class == King && piece.color == color
    end

    king.pos
  end

  #color of the king that is possibly checked
  def in_check?(color)
    # debugger
    enemy_color = color == :white ? :black : :white
    enemy_pieces = @grid.flatten.select { |piece| piece.color == enemy_color }
    enemy_next_avail_moves = []
    enemy_pieces.each { |piece| enemy_next_avail_moves += piece.avail_moves }

    my_king = find_king(color)
    enemy_next_avail_moves.include?(my_king)
  end

  def dup
    dup_board = Board.new(false)
    @grid.each do |row|
      row.each do |cell|
        cell.dup(dup_board)
      end
    end
    dup_board
  end

  def inspect
    true
  end
end
