class Square
  attr_accessor :symbol

  def initialize
    @symbol = ' '
  end

  def empty?
    self.symbol == ' '
  end

end
