require 'colorize'
require 'io/console'
require './player.rb'

class Display
  attr_reader :board, :cursor_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = nil
  end

  def print_out
    while true
      print_board
      new_pos = HumanPlayer.get_key(@cursor_pos)
      break unless new_pos
      @cursor_pos = new_pos if board.on_board?(new_pos)
    end
  end

  def update_cursor(new_pos)
    @cursor_pos = new_pos
    print_board
  end

  def print_board
    system 'clear'
    board.grid.each_with_index do |row, row_i|
      print_row(row, row_i)
    end
    true
  end

  def print_row(row, row_i)
    row.each_with_index do |el, cell_i|
      if @cursor_pos == [row_i, cell_i]
        print el.to_s.colorize( :background => :yellow)
      elsif (row_i + cell_i).even?
        print el.to_s.colorize( :background => :blue)
      else
        print el.to_s.colorize( :background => :green)
      end
    end
    print "\n"
  end
end
