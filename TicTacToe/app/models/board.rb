class InvalidMovement < StandardError
end

class InvalidLocation < StandardError
end

class Board < ApplicationRecord
  attr_reader :board

  def initialize_board
    @board = Array.new(9, ' ')
  end

  def make_movement(movement, player)
    raise InvalidLocation.new("Invalid location") if movement < 0 || movement > 8
    raise InvalidMovement.new("Invalid movement, that cell is already marked") if @board[movement] != ' '
    # Ensures that the player is 'O' or 'X'
    @board[movement] = player.symbol
  end

 # Check if there is a winner
  def winner?
    winning_combinations.each do |combination|
      values = combination.map { |index| @board[index] }
      return values.first if values.uniq.length == 1 && values.first != ' '
    end
    nil
  end

  def get_moves
    @board.each_index.select { |i| @board[i] == ' ' }
  end

  # Check if the game is a draw
  def draw?
    @board.none? { |cell| cell == ' ' } && winner?.nil?
  end

  private

  # Define winning combinations dynamically
  def winning_combinations
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end
end
