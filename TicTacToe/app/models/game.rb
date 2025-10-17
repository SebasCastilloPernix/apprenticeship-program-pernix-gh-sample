class Game < ApplicationRecord
  attr_reader :board, :player1, :player2, :current_turn

  # To initialize the board into the game
  def initialize_board
    @board = Board.new
    @board.initialize_board
  end

  # To initialize the player into the game
  def initialize_players(option)
    begin    
      @player1 = Player.new
      @player1.initialize_player(option)
      option = option == 'X' ? 'O' : 'X'
      @player2 = Player.new
      @player2.initialize_player(option)
      @current_turn = @player1
    rescue ArgumentError => e
      raise e
    end
  end

  # Initializes the game
  def initialize_game(symbol)
    initialize_board
    initialize_players(symbol)
  end
end
