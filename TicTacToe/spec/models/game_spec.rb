RSpec.describe Game, type: :model do
  describe '#initialize_symbol' do
    # Test's name
    it 'Validate the current player X' do
      game = Game.new
      player1 = Player.new
      player2 = Player.new
      game.initialize_game('X')
      player1.initialize_player('X')
      player2.initialize_player('O')
      expect(game.current_turn.symbol).to eq(player1.symbol)
    end

    it 'Validate that the other player is waiting for its turn O' do
      game = Game.new
      player1 = Player.new
      player2 = Player.new
      game.initialize_game('X')
      player1.initialize_player('X')
      player2.initialize_player('O')
      expect(game.current_turn.symbol).not_to eq(player2.symbol)
    end

    it 'Validate the current player O' do
      game = Game.new
      player1 = Player.new
      player2 = Player.new
      game.initialize_game('O')
      player1.initialize_player('O')
      player2.initialize_player('X')
      expect(game.current_turn.symbol).to eq(player1.symbol)
    end

    it 'Validate that the other player is waiting for its turn X' do
      game = Game.new
      player1 = Player.new
      player2 = Player.new
      game.initialize_game('O')
      player1.initialize_player('O')
      player2.initialize_player('X')
      expect(game.current_turn.symbol).not_to eq(player2.symbol)
    end

    it 'Validate that the player can do a move' do
      game = Game.new
      game.initialize_game('X')
      game.make_move(3)
      expect(game.board.board[3]).to eq('X')
    end

    it 'Validate that the game switch the turns' do
      game = Game.new
      game.initialize_game('X')
      expect(game.current_turn.symbol).to eq('X')
      game.make_move(3)
      expect(game.current_turn.symbol).to eq('O')
    end

    it 'Validate that the game switch the turns' do
      game = Game.new
      game.initialize_game('O')
      expect(game.current_turn.symbol).to eq('O')
      game.make_move(3)
      expect(game.current_turn.symbol).to eq('X')
    end
  end

  describe '#check_game_status' do
    it 'returns the winner when a row is completed' do
      game = Game.new
      game.initialize_game('X')
      game.make_move(0) # X
      game.make_move(3) # O
      game.make_move(1) # X
      game.make_move(4) # O
      result = game.make_move(2) # X wins
      expect(result[:status]).to eq(:finished)
      expect(result[:message]).to eq("El ganador es el jugador 'X'")
    end

    it 'returns the winner when a column is completed' do
      game = Game.new
      game.initialize_game('O')
      game.make_move(0) # O
      game.make_move(1) # X
      game.make_move(3) # O
      game.make_move(2) # X
      result = game.make_move(6) # O wins
      expect(result[:status]).to eq(:finished)
      expect(result[:message]).to eq("El ganador es el jugador 'O'")
    end

    it 'returns the winner when a diagonal is completed' do
      game = Game.new
      game.initialize_game('X')
      game.make_move(0) # X
      game.make_move(1) # O
      game.make_move(4) # X
      game.make_move(2) # O
      result = game.make_move(8) # X wins
      expect(result[:status]).to eq(:finished)
      expect(result[:message]).to eq("El ganador es el jugador 'X'")
    end

    it 'returns a draw when the board is full and there is no winner' do
      game = Game.new
      game.initialize_game('X')
      game.make_move(0) # X
      game.make_move(1) # O
      game.make_move(2) # X
      game.make_move(4) # O
      game.make_move(3) # X
      game.make_move(5) # O
      game.make_move(7) # X
      game.make_move(6) # O
      result = game.make_move(8) # X
      expect(result[:status]).to eq(:finished)
      expect(result[:message]).to eq("El juego terminó en empate.")
    end

    it 'returns ongoing when the game is not finished' do
      game = Game.new
      game.initialize_game('X')
      result = game.make_move(0) # X
      expect(result[:status]).to eq(:ongoing)
      expect(result[:message]).to eq("Turno de 'O'.")
    end
  end
end