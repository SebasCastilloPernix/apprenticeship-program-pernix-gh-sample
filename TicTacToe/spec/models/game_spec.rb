RSpec.describe Game, type: :model do
  describe '#initialize_symbol' do
    game = Game.new
    player1 = Player.new
    player2 = Player.new
    # Test's name
    it 'Validate the current player X' do
      game.initialize_game('X')
      player1.initialize_player('X')
      player2.initialize_player('O')
      expect(game.current_turn.symbol).to eq(player1.symbol)
    end
    it 'Validate that the other player is waiting for its turn O' do
      game.initialize_game('X')
      player1.initialize_player('X')
      player2.initialize_player('O')
      expect(game.current_turn.symbol).not_to eq(player2.symbol)
    end
    it 'Validate the current player O' do
      game.initialize_game('O')
      player1.initialize_player('O')
      player2.initialize_player('X')
      expect(game.current_turn.symbol).to eq(player1.symbol)
    end
    it 'Validate that the other player is waiting for its turn X' do
      game.initialize_game('O')
      player1.initialize_player('O')
      player2.initialize_player('X')
      expect(game.current_turn.symbol).not_to eq(player2.symbol)
    end
  end
end