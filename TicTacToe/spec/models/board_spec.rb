require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '#initialize_board' do
    it 'creates a board with size nine' do
      board = Board.new
      board.initialize_board
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
      
      expect { board.make_movement(9, player) }.to raise_error(InvalidLocation)
    end

    it 'invalid movement' do
      player1 = double('Player', symbol: 'X')
      player2 = double('Player', symbol: 'O')

      board = Board.new
      board.initialize_board
      
      board.make_movement(3, player1)
      
      expect { board.make_movement(3, player2) }.to raise_error(InvalidMovement)
    end
  end

  describe '#winner?' do
    it 'returns the winner when a row is completed' do
      player = double('Player', symbol: 'X')

      board = Board.new
      board.initialize_board

      board.make_movement(0, player)
      board.make_movement(1, player)
      board.make_movement(2, player)

      expect(board.winner?).to eq('X')
    end

    it 'returns the winner when a column is completed' do
      player = double('Player', symbol: 'O')

      board = Board.new
      board.initialize_board

      board.make_movement(0, player)
      board.make_movement(3, player)
      board.make_movement(6, player)

      expect(board.winner?).to eq('O')
    end

    it 'returns the winner when a diagonal is completed' do
      player = double('Player', symbol: 'X')

      board = Board.new
      board.initialize_board

      board.make_movement(0, player)
      board.make_movement(4, player)
      board.make_movement(8, player)

      expect(board.winner?).to eq('X')
    end

    it 'returns nil when there is no winner' do
      player1 = double('Player', symbol: 'X')
      player2 = double('Player', symbol: 'O')

      board = Board.new
      board.initialize_board

      board.make_movement(0, player1)
      board.make_movement(1, player2)
      board.make_movement(2, player1)

      expect(board.winner?).to be_nil
    end
  end

  describe '#draw?' do
    it 'returns true when the board is full and there is no winner' do
      player1 = double('Player', symbol: 'X')
      player2 = double('Player', symbol: 'O')

      board = Board.new
      board.initialize_board

      board.make_movement(0, player1)
      board.make_movement(1, player2)
      board.make_movement(2, player1)
      board.make_movement(3, player2)
      board.make_movement(4, player1)
      board.make_movement(5, player2)
      board.make_movement(6, player2)
      board.make_movement(7, player1)
      board.make_movement(8, player2)

      expect(board.draw?).to be true
    end

    it 'returns false when the board is not full' do
      player1 = double('Player', symbol: 'X')
      player2 = double('Player', symbol: 'O')

      board = Board.new
      board.initialize_board

      board.make_movement(0, player1)
      board.make_movement(1, player2)

      expect(board.draw?).to be false
    end

    it 'returns false when there is a winner' do
      player = double('Player', symbol: 'X')

      board = Board.new
      board.initialize_board

      board.make_movement(0, player)
      board.make_movement(1, player)
      board.make_movement(2, player)

      expect(board.draw?).to be false
    end
  end
end