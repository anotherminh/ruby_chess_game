#Chess

![chess](chess.png)

This is a 2-player chess game, playable from the Terminal. To play, simply
download the file as .zip, then open up your terminal and run this line
from the game's directory:

`ruby game.rb`

To select your move, use the arrow keys. To select or unselect a piece/move, press Enter.

###Code Highlights
The pieces' behaviors have overlapping logic. So, I allow them to inherit
from the Piece parent class, which holds the default methods for checking
for kill moves and occupied squares.

<pre><code>
def kill_move?(pos)
  if board.on_board?(pos)
    return board.occupied?(pos) && board[pos].color != color
  end
  false
end

def occupied?
  true
end
</pre></code>

Of course, the Piece parent class also defines the initialize method,
because every piece needs to store the same info:

<pre><code>
def initialize(color, pos, board)
  @value = nil
  @color = color
  @pos = pos
  @board = board
  @board[pos] = self
end
</pre></code>

I also factor out the shared logic for moves at a lower level (into modules).
An example is the king and the pawn.
They are both "stepping" pieces, in the sense that they can only move one square at a time.
(The pawn can move two on its first move, but that's just extra code in the pawn
class that overrides the module).

<pre><code>
module Slidable
  def avail_moves
    valid_moves = []
    deltas.each do |delta|
      new_valid = [pos[0] + delta[0], pos[1] + delta[1]]

      while board.empty_square_on_board?(new_valid)
        valid_moves << new_valid
        new_valid = [new_valid[0] + delta[0], new_valid[1] + delta[1]]
      end

      if kill_move?(new_valid)
        valid_moves << new_valid
      end
    end
    valid_moves
  end
end
</pre></code>

Another example is the bishop, rook and queen, which
are all "sliding" pieces: they can move for as many steps as possible (without
jumping over other pieces) in some specified direction.

<pre><code>
module Steppable
  def avail_moves
    valid_moves = []
    deltas.each do |delta|
      new_valid = [pos[0] + delta[0], pos[1] + delta[1]]

      if board.empty_square_on_board?(new_valid) || kill_move?(new_valid)
        valid_moves << new_valid
      end
    end
    valid_moves
  end
end
</pre></code>

Instead of having to type-check my moves on the board when interacting with
empty squares, I wrote a null object that can handle the same sort of
functions that are called on piece object when generating/checking for valid moves:

<pre><code>
class EmptySquare < Piece
  def initialize(_, pos, board)
    super(:nope, pos, board)
    @value = '  '
  end

  def occupied?
    false
  end

  def avail_moves
    []
  end
end
</pre></code>
