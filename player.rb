class Player
  attr_reader :name, :symbol

  def initialize(n, s)
    @symbol = s
    @name   = n
  end

  def mark_square(board, position)
    board[position].symbol = @symbol
  end

  def to_s
    "Player: #{@name} (#{@symbol}) "
  end


end
