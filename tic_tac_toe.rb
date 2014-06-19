require './board'

class TicTacToe
  # attr_accessor

  def initialize
    p1_name   = prompt("Player 1: Your name? (Enter '#' for computer)", 'Nish')
    p1_name   = 'Computer-1' if p1_name == '#'
    p1_symbol = prompt("What symbol would you like to play with #{p1_name}", 'X').upcase[0]
    @player1 = Player.new(p1_name, p1_symbol)

    p2_name   = prompt("Player 2: Your name? (Enter '#' for computer)", 'Sidd')
    p2_name   = 'Computer-2' if p2_name == '#'
    p2_symbol = p1_symbol
    while p2_symbol == p1_symbol
      p2_symbol = prompt("What symbol would you like to play with #{p2_name} ('#{p1_symbol}' is taken)", 'O').upcase[0]
    end
    @player2 = Player.new(p2_name, p2_symbol)

    @board = Board.new()

    @current_player = @player1

  end


  def play

    while true
      display_board
      cell_index = player_picks_cell
      winner = @board.mark_cell_and_check_winner(@current_player, cell_index)
      if winner
        display_board
        puts "#{winner.name} Won! Game Over!\n\n"
        break
      elsif @board.full?
        display_board
        puts "Game tied.\n\n"
        break
      else
        swap_player
      end
    end

  end


  private


  def player_picks_cell()

    if @current_player.name.include?('Computer-')
      cell_index = @board.empty_cells.sample
    else
      puts @board.display_helper + "#{@current_player} to play..."
      cell_index = 'invalid'
      until @board.valid?(cell_index)
        default = @board.empty_cells.length == 1 ? "#{@board.empty_cells[0]+1}" : ''
        cell_index = prompt('Enter a number denoting an available cell', default)[0].to_i
        cell_index = cell_index > 0 ? cell_index - 1 : 'invalid'
      end
    end

    cell_index

  end


  def display_board
    puts "#{@player1} | #{@player2} \n #{@board}\n"
  end


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


  def swap_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end


end

g = TicTacToe.new
g.play