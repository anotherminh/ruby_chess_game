require 'byebug'
require './board'
require './player'
require './display'

class Chess
  attr_reader :board, :display, :player1, :player2, :current_player

  def initialize(players, board = nil)
    @board = board || Board.new
    @display = Display.new(@board)
    @player1 = players[0]
    @player2 = players[1]
    @current_player = player1
  end

  def play
    #need to check if over or checkmate
    until board.check_mate?
      play_round
      switch_player!
    end
  end

  def play_round
    @selected = false
    @moved = false
    @selected_pos = choose_piece
    move_piece(@selected_pos)
    display.print_board
    if board.in_check?(current_player.color)
      puts "Checking!"
      sleep(1)
    elsif board.check_mate?
    puts "Checkmate!~"
      sleep(1)
    end
  end

  def switch_player!
    @current_player = @current_player == player1 ? player2 : player1
  end

  def choose_piece
    selected_pos = nil
    until @selected
      display.print_board
      # debugger
      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input) if board.on_board?(new_input)
      else
        selected_pos = display.cursor_pos
        @selected = true if board.valid_selection?(current_player.color, selected_pos)
      end
    end
    selected_pos
  end

  def move_piece(selected_pos)
    until @moved
      display.print_board(@selected_pos)
      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input) if board.on_board?(new_input)
      else
        new_pos = display.cursor_pos
        if board.valid_move?(@selected_pos, new_pos, current_player.color)
          # board.empty_square_on_board?(new_pos)
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
  # board = Board.new(false)
  board = Board.new
  player1 = HumanPlayer.new(:red)
  player2 = HumanPlayer.new(:black)
  players = [player1, player2]
  #debugger
  game = Chess.new(players, board)

  # queen = Queen.new(:black, [5,6], board)
  # #bishop = Bishop.new(:black, [0, 1], board)
  # rook = Rook.new(:black, [0, 0], board)
  # king = King.new(:white, [1, 1], board)
  # knight = Knight.new(:white, [6, 6], board)
  # black_king = King.new(:black, [7, 7], board)

  game.play
end
