require_relative 'display'

class HumanPlayer
  # Reads keypresses from the user including 2 and 3 escape character sequences.
  def self.read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def self.get_key(cursor_pos)
    c = read_char
    new_pos = cursor_pos.dup
    case c
    when "\e[A"
      # puts "UP ARROW"
      new_pos[0] -= 1
    when "\e[B"
      # puts "DOWN ARROW"
      new_pos[0] += 1
    when "\e[C"
      # puts "RIGHT ARROW"
      new_pos[1] += 1
    when "\e[D"
      # puts "LEFT ARROW"
      new_pos[1] -= 1
    when "\r"
      new_pos = false
    when "\e"
      Kernel.abort
    end
    new_pos
  end

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def show_display(display)
    @display = display
  end

  def make_move(board)
    @board = board
    @selected = false
    @moved = false
    choose_piece
    move_piece
  end

  def choose_piece
    selected_pos = nil
    until @selected
      display.print_board

      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input) if board.on_board?(new_input)
      else
        @selected_pos = display.cursor_pos
        @selected = true if board.valid_selection?(color, @selected_pos)
      end
    end
    selected_pos
  end

  def move_piece
    until @moved
      display.print_board(selected_pos)
      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input) if board.on_board?(new_input)
      else
        new_pos = display.cursor_pos
        if new_pos == @selected_pos
          @selected = false
          choose_piece
        elsif board.valid_move?(@selected_pos, new_pos, color)
          @moved = true
          board.move_piece(@selected_pos, new_pos)
        end
      end
    end
  end

  private
  attr_accessor :display, :board, :selected_pos
end
