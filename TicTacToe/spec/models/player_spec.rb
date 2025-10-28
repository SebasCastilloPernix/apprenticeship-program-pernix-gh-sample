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
end