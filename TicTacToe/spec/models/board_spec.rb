require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '#initialize_board' do
    # Name of the test
    it 'creates a board with size nine' do
      board = Board.new
      board.initialize_board
      # expected output
      expect(board.board.size).to eq(9)
    end

    it 'creates a board with empty nine spaces' do
      board = Board.new
      board.initialize_board
      expect(board.board.all? { |cell| cell == ' ' }).to be true
    end

    it 'validate that cell is correct' do
      player = double('Player', symbol: 'X')

      board = Board.new
      board.initialize_board
      
      board.make_movement(3, player)
      expect(board.board[3]).to eq('X')
    end

    it 'validate that cell is incorrect' do
      player = double('Player', symbol: 'O')

      board = Board.new
      board.initialize_board
      
      board.make_movement(3, player)
      expect(board.board[3]).not_to eq('X')
    end

    it 'invalid location' do
      player = double('Player', symbol: 'X')

      board = Board.new
      board.initialize_board
      
      
      expect{ board.make_movement(9, player) }.to raise_error(InvalidLocation)
    end

    it 'invalid movement' do
      player1 = double('Player', symbol: 'X')
      player2 = double('Player', symbol: 'O')

      board = Board.new
      board.initialize_board
      
      board.make_movement(3, player1)
      
      expect{ board.make_movement(3, player2) }.to raise_error(InvalidMovement)
    end
  end
end
