class GameSessionService
  def initialize(session, game)
    @session = session
    @game = game
  end

  def save_state_after_start
    @session[:board] = @game.board.board
    @session[:current_turn] = @game.current_turn.symbol
    @session[:game_status] = 'ongoing'
  end

  def save_result(result)
    @session[:board] = @game.board.board
    @session[:game_status] = result[:status].to_s
    @session[:current_turn] = @game.current_turn.symbol unless result[:status] == :finished
    @session[:result] = result
  end

  def game_finished?
    @session[:game_status].to_s == 'finished'
  end

  def reset!
    @session.delete(:board)
    @session.delete(:current_turn)
    @session.delete(:game_status)
    @session.delete(:result)
  end
end