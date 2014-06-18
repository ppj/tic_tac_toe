require 'pry'
require './board'

class TicTacToe
  # attr_accessor

  def initialize
    p1_name   = prompt("Player 1: Your name? (Enter '#' for computer)", "Sidd")
    p1_symbol = prompt("What symbol would you like to play with #{p1_name}", "X").upcase[0]
    p2_name   = prompt("Player 2: Your name? (Enter '#' for computer)", "Nish")
    p2_symbol = prompt("What symbol would you like to play with #{p2_name}", "O").upcase[0]

    p1 = Player.new(p1_name, p1_symbol)
    p2 = Player.new(p2_name, p2_symbol)

    @board = Board.new(p1, p2)

  end


  def run

    until @board.full?
      # binding.pry
      puts @board
      puts @board.display_helper
      while true
        position = gets.chomp().to_i - 1
        if @board.empty_positions.include?(position)
          break
        else
          puts "Please enter a valid position number (refer the board displayed above)"
        end
      end

      if @board.mark_position_and_check_winner(position)
        break
      end
    end

  end


  private

  def prompt(string, default)
    print "#{string} (Default: '#{default}') >> "
    response = gets.chomp
    if response.empty?
      response = default
    end
    response
  end

end

g = TicTacToe.new
g.run