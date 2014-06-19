require './cell'
require './player'

class Board

  attr_reader :cells


  def initialize()
    @cells = []
    9.times {@cells << Cell.new}
  end


  def to_s
    system "cls"
    helper = self.cells.map {|cell| cell.symbol}
    draw_board(helper)
  end


  def display_helper
    idx = 0
    helper = self.cells.map do |cell|
      idx += 1
      cell.symbol == ' ' ? "#{idx}" : cell.symbol
    end
    "Reference board:\n" + draw_board(helper)
  end


  def valid?(cell_index)
    cell_index.class == Fixnum ? self.cells[cell_index].empty? : false
  end


  def mark_cell_and_check_winner(player, cell_index)
    if self.valid?(cell_index)
      player.mark_cell(self, cell_index)
      return check_winner(player)
    end
    puts "Please select an empty square on the board"
    return false
  end


  def empty_cells
    empty_cells = []
    self.cells.each_with_index {|e, idx| empty_cells << idx if e.empty? }
    empty_cells
  end


  def full?
    self.empty_cells.empty?
  end


  private


  def check_winner(player)
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

    if self.empty_cells.length > 4
      return false
    end

    winning_patterns.each do |pattern|
      if player.symbol == self.cells[pattern[0]-1].symbol and
         player.symbol == self.cells[pattern[1]-1].symbol and
         player.symbol == self.cells[pattern[2]-1].symbol

        return player
      end
    end

    false

  end



  def draw_board(arr)
    "\n #{arr[0]} | #{arr[1]} | #{arr[2]} " +
    "\n---+---+---" +
    "\n #{arr[3]} | #{arr[4]} | #{arr[5]} " +
    "\n---+---+---" +
    "\n #{arr[6]} | #{arr[7]} | #{arr[8]} \n\n"
  end

end
