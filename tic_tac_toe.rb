require 'pry'
require './board'

class TicTacToe
  # attr_accessor

  def initialize
    p1_name   = prompt("Player 1: Your name? (Enter '#' for computer)", "Sidd")
    p1_symbol = prompt("What symbol would you like to play with #{p1_name}", "X").upcase[0]
    p1 = Player.new(p1_name, p1_symbol)

    p2_name   = prompt("Player 2: Your name? (Enter '#' for computer)", "Nish")
    p2_symbol = p1_symbol
    while p2_symbol == p1_symbol
      p2_symbol = prompt("What symbol would you like to play with #{p2_name} ('#{p1_symbol}' is taken)", "O").upcase[0]
    end

    p2 = Player.new(p2_name, p2_symbol)

    @board = Board.new(p1, p2)

  end


  def run

    until @board.full?
      puts @board
      puts @board.display_helper
      while true
        cell = prompt("Enter a number denoting an available cell", "")[0].to_i
        cell = cell > 0 ? cell - 1 : "invalid"
        # binding.pry
        if @board.valid?(cell)
          break
        end
      end

      if @board.mark_cell_and_check_winner(cell)
        break
      end
    end

    if @board.full?
      puts @board
      puts "\nGame tied.\n\n"
    end

  end


  private

  def prompt(string, default)
    if default.empty?
      prompt_string = "#{string} >> "
    else
      prompt_string = "#{string} (Default: '#{default}') >> "
    end
    print prompt_string
    response = gets.chomp
    if response.empty?
      response = default
    end
    response
  end

end

g = TicTacToe.new
g.run