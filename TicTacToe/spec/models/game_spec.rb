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
end