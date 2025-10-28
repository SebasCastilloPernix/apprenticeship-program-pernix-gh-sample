require 'rails_helper'

RSpec.describe AiPlayer, type: :model do
  let(:ai_player) { AiPlayer.new }
  let(:board) { Board.new }

  before do
    ai_player.initialize_player('X')
    board.initialize_board
  end

  describe '#evaluate' do
    it 'returns 10 if AI wins' do
      board.board[0] = 'X'
      board.board[1] = 'X'
      board.board[2] = 'X'
      expect(ai_player.send(:evaluate, board)).to eq(10)
    end

    it 'returns -10 if opponent wins' do
      board.board[0] = 'O'
      board.board[1] = 'O'
      board.board[2] = 'O'
      expect(ai_player.send(:evaluate, board)).to eq(-10)
    end

    it 'returns 0 if no winner' do
      board.board[0] = 'X'
      board.board[1] = 'O'
      board.board[2] = 'X'
      expect(ai_player.send(:evaluate, board)).to eq(0)
    end
  end

  describe '#find_best_move' do
    it 'finds the winning move for AI' do
      board.board[0] = 'X'
      board.board[1] = 'X'
      board.board[2] = ' '
      expect(ai_player.find_best_move(board)).to eq(2)
    end

    it 'blocks opponent winning move' do
      board.board[0] = 'O'
      board.board[1] = 'O'
      board.board[2] = ' '
      expect(ai_player.find_best_move(board)).to eq(2)
    end

    it 'returns nil if no moves left' do
      (0..8).each { |i| board.board[i] = 'X' }
      expect(ai_player.find_best_move(board)).to be_nil
    end
  end

  describe '#minimax' do
    it 'returns 10 for AI win' do
      board.board[0] = 'X'
      board.board[1] = 'X'
      board.board[2] = 'X'
      expect(ai_player.send(:minimax, board, 0, true)).to eq(10)
    end

    it 'returns -10 for opponent win' do
      board.board[0] = 'O'
      board.board[1] = 'O'
      board.board[2] = 'O'
      expect(ai_player.send(:minimax, board, 0, true)).to eq(-10)
    end

    it 'returns 0 for draw' do
      ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'].each_with_index do |value, index|
        board.board[index] = value
      end
      expect(ai_player.send(:minimax, board, 0, true)).to eq(0)
    end
  end
end
