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
end
