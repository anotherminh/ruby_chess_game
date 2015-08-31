require 'byebug'
require './board'
require './player'
require './display'

class Chess
  attr_reader :board, :display

  def initialize(players = nil)
    @board = Board.new
    @display = Display.new(@board)
    @player = HumanPlayer.new
  end
  # def print_out
  #   while true
  #     print_board
  #     new_pos = HumanPlayer.get_key(@cursor_pos)
  #     break unless new_pos
  #     @cursor_pos = new_pos if board.on_board?(new_pos)
  #   end
  # end

  def play_round
    @selected = false
    @moved = false

    until @selected
      display.print_board
      new_input = HumanPlayer.get_key(display.cursor_pos)

      p @selected
      p new_input
      # debugger
      if new_input
        display.update_cursor(new_input)
      else
        selected_pos = display.cursor_pos
        @selected = true if board.occupied?(selected_pos)
      end

    end

    until @moved
      display.print_board
      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input)
      else
        # debugger
        new_pos = display.cursor_pos
        unless board.occupied?(new_pos)
          @moved = true
          board.move_piece(selected_pos, new_pos)
        end
      end
    end
    display.print_board
  end

  def inspect
    true
  end
end
