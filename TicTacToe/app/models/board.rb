class Board < ApplicationRecord
  attr_reader :board

  def initialize_board
    @board = Array.new(9, ' ')
  end
end
