require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '#initialize_board' do
    # create a 'global variable to test the board'
    board = Board.new
    board.initialize_board
    # Name of the test
    it 'creates a board with size nine' do
      # expected output
      expect(board.board.size).to eq(9)
    end

    it 'creates a board with empty nine spaces' do
      expect(board.board.all? { |cell| cell == ' ' }).to be true
    end
  end
end
