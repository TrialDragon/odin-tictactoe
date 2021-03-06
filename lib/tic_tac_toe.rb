require 'pry-byebug'


class Grid
  attr_accessor :symbol_array
  attr_reader :grid_side_length, :default_grid_character

  def initialize
    @grid_side_length = 3
    @default_grid_character = ' '
    @symbol_array = Array.new(@grid_side_length) { Array.new(@grid_side_length) { @default_grid_character } }
  end

  def won?(player)
    (vertical_win?(player.symbol) or horizontal_win?(player.symbol) or diagonal_win?(player.symbol))
  end

  def display
    puts "#{symbol_array[0][0]}|#{symbol_array[0][1]}|#{symbol_array[0][2]}
─┼─┼─
#{symbol_array[1][0]}|#{symbol_array[1][1]}|#{symbol_array[1][2]}
─┼─┼─
#{symbol_array[2][0]}|#{symbol_array[2][1]}|#{symbol_array[2][2]}\n"
  end

  def array(indices)
    symbol_array[indices[0]][indices[1]]
  end

  def array_assign(indices, value)
    symbol_array[indices[0]][indices[1]] = value
  end

  private

  def horizontal_win?(player_symbol)
    result = false
    @symbol_array.each do |element|
      result ||= element.all? do |symbol|
        symbol == player_symbol
      end
    end
    result
  end

  def vertical_win?(player_symbol)
    column_results = Array.new(3) { true }
    (0..3).each do |i|
      @symbol_array.each do |inner_array|
        column_results[i] &&= inner_array[i] == player_symbol
      end
    end
    column_results.any?
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
    until ((0..2).member? input) && ((0..2).member? input_two)
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
    [prng.rand(0..2), prng.rand(0..2)]
  end
end

def choose_players
  num_of_players = 0
  until (1..2).member? num_of_players
    puts 'Input a number of players 1 -- 2'
    num_of_players = gets.to_i
  end
  num_of_players
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

winner = Player.new :wrong
win = false
turn_counter = 0
until win
  turn_counter += 1
  current_player = turn_counter.even? ? player_x : player_o
  valid_choice = false
  until valid_choice
    player_choice = current_player.square_choice
    if game_grid.array(player_choice) == game_grid.default_grid_character
      game_grid.array_assign(player_choice, current_player.symbol)
      valid_choice = true
    end
  end
  game_grid.display
  win = game_grid.won? current_player
  winner = current_player if win
end

puts "Congratz! #{winner.symbol} has won!"
