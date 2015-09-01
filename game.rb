require 'byebug'
require './board'
require './player'
require './display'

class Chess
  attr_reader :board, :display

  def initialize(player, board = nil)
    @board = board || Board.new
    @display = Display.new(@board)
    @player = player
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
        selected_pos = display.cursor_pos
        @selected = true if board.valid_selection?(selected_pos)
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
        if board.empty_square_on_board?(new_pos)
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

if $PROGRAM_NAME == __FILE__
  board = Board.new(false)
  player = HumanPlayer.new(:white)
  #debugger
  game = Chess.new(player, board)

  queen = Queen.new(:black, [5,6], board)
  #bishop = Bishop.new(:black, [0, 1], board)
  rook = Rook.new(:black, [0, 0], board)
  king = King.new(:white, [1, 3], board)
  knight = Knight.new(:white, [6, 6], board)
  black_king = King.new(:black, [7, 7], board)
  
  game.play_round
end
