require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#initialize_symbol' do
    player = Player.new
    # Test's name
    it 'creates a player with X symbol' do
      player.initialize_player('X')
      expect(player.symbol).to eq('X')
    end

    it 'creates a player with O symbol' do
      player.initialize_player('O')
      expect(player.symbol).to eq('O')
    end

    it 'creates a player with X symbol and validate if is not O' do
      player.initialize_player('X')
      expect(player.symbol).not_to eq('O')
    end

    it 'creates a player with O symbol and validate if is not X' do
      player.initialize_player('O')
      expect(player.symbol).not_to eq('X')
    end

    it 'invalid symbol and expect ArgumentError' do
      expect{player.initialize_player('-')}.to raise_error(ArgumentError)
      expect{player.initialize_player('s')}.to raise_error(ArgumentError)
      expect{player.initialize_player('S')}.to raise_error(ArgumentError)
      expect{player.initialize_player('m')}.to raise_error(ArgumentError)
      expect{player.initialize_player('d')}.to raise_error(ArgumentError)
    end
  end
end
