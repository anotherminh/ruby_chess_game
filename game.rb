require 'byebug'
require './board'
require './player'
require_relative 'display'

class Chess
  attr_reader :board, :players, :display

  def initialize(players, board = Board.new)
    @board = board
    @players = players
    @display = Display.new(board)
  end

  def play
    until board.check_mate?(current_player.color)
      current_player.show_display(display)
      current_player.make_move(board)
      switch_player!
    end
  end

  def current_player
    players[0]
  end

  def switch_player!
    players.rotate!
  end

  def inspect
    true
  end
end

if $PROGRAM_NAME == __FILE__
  # board = Board.new(false)
  board = Board.new
  player1 = HumanPlayer.new(:white)
  player2 = HumanPlayer.new(:black)
  players = [player1, player2]
  #debugger
  game = Chess.new(players, board)

  # pawn = Pawn.new(:black, [4, 6], board)
  # queen = Queen.new(:black, [5,6], board)
  # #bishop = Bishop.new(:black, [0, 1], board)
  # rook = Rook.new(:black, [0, 0], board)
  # king = King.new(:red, [1, 1], board)
  # knight = Knight.new(:white, [6, 6], board)
  # black_king = King.new(:black, [7, 7], board)

  game.play
end
