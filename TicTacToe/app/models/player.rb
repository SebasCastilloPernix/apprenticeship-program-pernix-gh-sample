class Player < ApplicationRecord
  attr_reader :symbol

  def initialize_player(option)
    raise ArgumentError, "The option must be 'X' or 'O', not '#{option}'" unless %w[X O].include?(option)

    @symbol = option
  end
end
