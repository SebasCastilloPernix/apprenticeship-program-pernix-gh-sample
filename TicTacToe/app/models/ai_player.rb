class AiPlayer < Player
  def initialize_player(option)
    super(option)
  end

  def find_best_move(board_obj)
    best_val = -10000000
    best_move = nil
    ai_symbol = @symbol

    board_obj.get_moves.each do |move|
      board_obj.board[move] = ai_symbol
      move_val = minimax(board_obj, 8, false)
      board_obj.board[move] = ' '
      if move_val > best_val
        best_val = move_val
        best_move = move
      end
    end

    best_move
  end

  private

  def minimax(board_obj, depth, is_max)
    score = evaluate(board_obj)
    return score if score.abs == 10
    return 0 if board_obj.get_moves.empty?

    if is_max
      best = -10000000
      board_obj.get_moves.each do |move|
        board_obj.board[move] = @symbol
        best = [best, minimax(board_obj, depth + 1, false)].max
        board_obj.board[move] = ' '
      end
      best
    else
      best = 10000000
      opponent = @symbol == 'X' ? 'O' : 'X'
      board_obj.get_moves.each do |move|
        board_obj.board[move] = opponent
        best = [best, minimax(board_obj, depth + 1, true)].min
        board_obj.board[move] = ' '
      end
      best
    end
  end

  def evaluate(board_obj)
    winner = board_obj.winner?
    return 10 if winner == @symbol
    return -10 if winner && winner != @symbol
    0
  end
end
