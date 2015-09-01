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

  def play

  end

  def play_round
    @selected = false
    @moved = false
    @selected_pos = choose_piece
    move_piece(@selected_pos)
    display.print_board
  end

  def choose_piece
    selected_pos = nil
    until @selected
      display.print_board
      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input) if board.on_board?(new_input)
      else
        selected_pos = display.cursor_pos if board.on_board?(new_input)
        @selected = true if board.valid_selection(selected_pos)
      end
    end
    selected_pos
  end

  def move_piece(selected_pos)
    until @moved
      display.print_board(@selected_pos)
      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input)
      else
        new_pos = display.cursor_pos
        unless board.valid_move?(new_pos)
          @moved = true
          board.move_piece(selected_pos, new_pos)
        end
      end
    end
  end

  def inspect
    true
  end
end
