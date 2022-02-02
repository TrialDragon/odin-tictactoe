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

  def display
    puts "#{symbol_array[0][0]}|#{symbol_array[0][1]}|#{symbol_array[0][2]}\\n
         ─┼─┼─┼─\\n
         #{symbol_array[1][0]}|#{symbol_array[1][1]}|#{symbol_array[1][2]}\\n
         ─┼─┼─┼─\\n
         #{symbol_array[2][0]}|#{symbol_array[2][1]}|#{symbol_array[2][2]}\\n"
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
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def square_choice; end
end

class UserPlayer < Player
  def square_choice
    input = -1
    input_two = -1
    until ((1..3).member? input) && ((1..3).member? input_two)
      puts 'Input the row you wish to place.'
      input = gets.to_i
      puts 'Input the col you wish to place.'
      input_two = gets.to_i
    end
    [input, input_two]
  end
end

class RobotPlayer < Player
  def square_choice
    prng = Random.new
    [prng.rand(1..3), prng.rand(1..3)]
  end
end

game_grid = Grid.new

case choose_players
when 1
  player_x = UserPlayer.new :X
  player_o = RobotPlayer.new :O
when 2
  player_x = UserPlayer.new :X
  player_o = UserPlayer.new :O
end

win = false
until win
  
end
