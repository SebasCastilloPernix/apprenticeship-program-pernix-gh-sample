class GameSessionService
  def initialize(session, game)
    @session = session
    @game = game
  end

  def save_state_after_start
    @session[:board] = @game.board.board
    @session[:current_turn] = @game.current_turn.symbol
    @session[:game_status] = 'ongoing'
    @session[:player_symbols] = [@game.player1.symbol, @game.player2.symbol]
  end

  def save_result(result)
    @session[:board] = @game.board.board
    @session[:game_status] = result[:status].to_s
    @session[:current_turn] = @game.current_turn.symbol unless result[:status] == :finished
    @session[:result] = result
    if @game.player1 && @game.player2
      @session[:player_symbols] = [@game.player1.symbol, @game.player2.symbol]
    end
  end

  def game_finished?
    @session[:game_status].to_s == 'finished'
  end
end