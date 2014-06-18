class Player
  attr_reader :name, :symbol

  def initialize(n, s)
    @symbol = s
    @name   = n
  end

  def mark_cell(board, cell)
    board.state[cell].symbol = self.symbol
  end

  def to_s
    "Player: #{@name} (#{@symbol}) "
  end


end
