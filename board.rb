require './square'
require './player'

class Board

  attr_reader :state, :player1, :player2


  def initialize(p1, p2)
    @state = []
    9.times {@state << Square.new}
    @player1 = p1
    @player2 = p2
    @current_player = player1
  end


  def to_s
    system "cls"
    helper = self.state.map {|pos| pos.symbol}
    "#{player1} | #{player2}\n" + draw_board(helper)
  end


  def display_helper
    idx = 0
    helper = self.state.map do |pos|
      idx += 1
      pos.symbol == ' ' ? "#{idx}" : pos.symbol
    end
    "\n#{@current_player}'s Turn\n" +
    "\nEmpty positions are marked with numbers above.\n" +
    "Pick a position using the corresponding number\n" + draw_board(helper)
  end


  def mark_position_and_check_winner(position)
    if self.state[position].empty?
      self.state[position].symbol = @current_player.symbol
      winner = check_winner
      @current_player = @current_player == player1 ? player2 : player1
      return winner
    end
    puts "Please select an empty square on the board"
    return false
  end


  def empty_positions
    positions = []
    self.state.each_with_index {|e, idx| positions << idx if e.empty? }
    positions
  end


  def full?
    self.empty_positions.empty?
  end


  private


  def check_winner()
    winning_patterns = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ]

    if self.empty_positions.length > 4
      return false
    end

    winning_patterns.each do |pattern|
      if player1.symbol == self.state[pattern[0]-1].symbol and
         player1.symbol == self.state[pattern[1]-1].symbol and
         player1.symbol == self.state[pattern[2]-1].symbol

        puts self
        puts "\n#{player1.name} Won! Game Over!\n\n"
        return player1
      elsif player2.symbol == self.state[pattern[0]-1].symbol and
            player2.symbol == self.state[pattern[1]-1].symbol and
            player2.symbol == self.state[pattern[2]-1].symbol

        puts self
        puts "\n#{player2.name} Won! Game Over!\n\n"
        return player2
      end
    end

    false

  end



  def draw_board(arr)
    "\n #{arr[0]} | #{arr[1]} | #{arr[2]} " +
    "\n---+---+---" +
    "\n #{arr[3]} | #{arr[4]} | #{arr[5]} " +
    "\n---+---+---" +
    "\n #{arr[6]} | #{arr[7]} | #{arr[8]} \n"
  end

end
