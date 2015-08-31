require 'colorize'

class Piece
  attr_reader :value, :color
  attr_accessor :pos

  def initialize(val, color, pos = [0, 0])
    @value = val
    @color = color
    @pos = pos
  end

  def moves
  end

  def occupied?
    !self.is_a?(EmptySquare)
  end

  def to_s
    value.colorize(color)
  end
end

class King < Piece
  def initialize(color, pos = [0, 0])
    super("\u2654 ", color, pos)
  end

  def moves
    new_pos = []
    (-1..1).to_a.each do |x|
      (-1..1).to_a.each do |y|
        i, j = @pos
        new_pos << [x + i, y + j] unless @pos == [x, y]
      end
    end
    new_pos
  end
end

class EmptySquare < Piece
  def initialize(pos)
    super('  ', :empty, pos)
  end
end
