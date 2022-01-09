
class Square
  attr_reader :symbol

  def initialize
    reset
  end

  def reset
    @symbol = @@emptyCharacter
  end

  def activateIfEmpty(symbol) 
    activate symbol if empty?
  end

  def empty?
    @symbol == @@emptyCharacter
  end

  private

  @@emptyCharacter = ' '

  def activate(symbol)
    @symbol = symbol
  end
end

class Grid
  attr_reader :squareGrid

  def initialize(size)
    @squareGrid = Array.new 
end
