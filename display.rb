require 'colorize'
require 'io/console'
require './player.rb'
require 'byebug'

class Display
  attr_reader :board, :cursor_pos

  def initialize(board)
    @board = board
    @cursor_pos = [7, 7]
    @selected_pos = nil
  end

  def update_cursor(new_pos)
    @cursor_pos = new_pos
  end

  def print_board(selected_pos = nil)
    highlight_center = selected_pos || @cursor_pos
    @valid_moves = board.valid_moves(board[highlight_center].color, highlight_center)
    system 'clear'
    board_str = ""
    board.grid.each_with_index do |row, row_i|
      board_str += print_row(row, row_i, highlight_center)
    end
    print board_str
    true
  end

  def print_row(row, row_i, selected_pos)
    printable_row = ""
    row.each_with_index do |el, cell_i|
      if @cursor_pos == [row_i, cell_i]
        printable_row += el.to_s.colorize( :background => :red)
      elsif @valid_moves.include?([row_i, cell_i])
        printable_row += el.to_s.colorize( :background => :yellow)
      elsif selected_pos == [row_i, cell_i]
        printable_row += el.to_s.colorize( :background => :orange)
      elsif (row_i + cell_i).even?
        printable_row += el.to_s.colorize( :background => :cyan)
      else
        printable_row += el.to_s.colorize( :background => :blue)
      end
    end
    printable_row += "\n"
  end
end
