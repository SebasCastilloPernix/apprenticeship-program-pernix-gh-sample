class Board < ApplicationRecord
  def initialize_board
    @board = Array.new(9, ' ')
  end
  def board
    @board
  end
end
