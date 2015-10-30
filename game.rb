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
  board = Board.new
  player1 = HumanPlayer.new(:white)
  player2 = HumanPlayer.new(:black)
  players = [player1, player2]

  game = Chess.new(players, board)

  game.play
end
