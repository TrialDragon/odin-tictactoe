require 'raylib'
require 'pry-byebug'

class Grid
  attr_accessor :symbol_array
  attr_reader :grid_side_length

  def initialize
    @grid_side_length = 3
    @symbol_array = Array.new(@grid_side_length) { Array.new(@grid_side_length) }
  end

  def won?(player_symbol)
    (vertical_win? player_symbol or horizontal_win? player_symbol or diagonal_win? player_symbol)
  end

  private

  def vertical_win?(player_symbol)
    result = false
    @symbol_array.each do |element|
      result ||= element.all? do |symbol|
        symbol == player_symbol
      end
    end
    result
  end

  def horizontal_win?(player_symbol)
    first_array = Array.new(3)
    second_array = Array.new(3)
    third_array = Array.new(3)
    @symbol_array.each do |element|
      first_array.push element[0] == player_symbol
      second_array.push element[1] == player_symbol
      third_array.push element[2] == player_symbol
    end
    (first_array.all? || second_array.all? || third_array.all?)
  end

  def diagonal_win?(player_symbol)
    first_array = [@symbol_array[0][0], @symbol_array[1][1], @symbol_array[2][2]]
    second_array = [@symbol_array[0][2], @symbol_array[1][1], @symbol_array[2][0]]
    first_diagonal = first_array.all? { |element| element == player_symbol }
    second_diagonal = second_array.all? { |element| element == player_symbol }
    (first_diagonal || second_diagonal)
  end
end

class Player

end

class UserPlayer < Player

end

class RobotPlayer < Player

end
