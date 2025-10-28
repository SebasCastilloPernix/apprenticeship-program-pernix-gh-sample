require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#initialize_player' do
    let(:player) { Player.new }

    context 'with valid symbols' do
      it 'creates a player with X symbol' do
        player.initialize_player('X')
        expect(player.symbol).to eq('X')
      end

      it 'creates a player with O symbol' do
        player.initialize_player('O')
        expect(player.symbol).to eq('O')
      end
    end

    context 'with invalid symbols' do
      it 'raises ArgumentError for unsupported characters' do
        %w[- s S m d].each do |symbol|
          expect { player.initialize_player(symbol) }.to raise_error(ArgumentError)
        end
      end

      it 'raises ArgumentError for nil input' do
        expect { player.initialize_player(nil) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for blank string' do
        expect { player.initialize_player('') }.to raise_error(ArgumentError)
      end
    end

    context 'with lowercase inputs' do
      it 'either normalizes to uppercase or raises an error' do
        expect { player.initialize_player('x') }.to raise_error(ArgumentError)
        expect { player.initialize_player('o') }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'Game status messages' do
    it 'returns the winner when a column is completed' do
      game = Game.new
      game.initialize_game('O')
      game.make_move(0) # O
      game.make_move(1) # X
      game.make_move(3) # O
      game.make_move(2) # X
      result = game.make_move(6) # O wins
      expect(result[:status]).to eq(:finished)
      expect(result[:message]).to match(/El ganador es el jugador 'O'/)
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
      expect(result[:message]).to match(/El ganador es el jugador 'X'/)
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
      expect(result[:message]).to match(/El juego terminó en empate/)
    end

    it 'returns ongoing when the game is not finished' do
      game = Game.new
      game.initialize_game('X')
      result = game.make_move(0) # X
      expect(result[:status]).to eq(:ongoing)
      expect(result[:message]).to match(/Turno de 'O'/)
    end
  end
end