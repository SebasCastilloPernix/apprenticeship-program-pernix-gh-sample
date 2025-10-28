class GameController < ApplicationController
  before_action :load_game_from_session, only: [:game, :make_move]

  def start_game
    @game = Game.new
    @game.initialize_board
    @game.initialize_players(params[:player_symbol])
    GameSessionService.new(session, @game).save_state_after_start
    redirect_to game_path, notice: "El juego ha comenzado. Juegas como '#{@game.current_turn.symbol}'."
  end

  def game
    @board = @game.board
    @current_turn = session[:current_turn]
  end

  def make_move
    if GameSessionService.new(session, @game).game_finished?
      redirect_to game_path, alert: "El juego ya ha terminado. Por favor, reinicia el juego para comenzar de nuevo." and return
    end

    begin
      result = @game.make_move(params[:cell_index].to_i)
      GameSessionService.new(session, @game).save_result(result)
      flash[:notice] = result[:message]
      redirect_to game_path
    rescue InvalidLocation, InvalidMovement => e
      flash[:alert] = e.message
      redirect_to game_path
    end
  end

  private

  def load_game_from_session
    @game = Game.new
    @game.initialize_board
    @game.board.instance_variable_set(:@board, session[:board]) if session[:board]

    if session[:player_symbols]
      player_symbols = session[:player_symbols]
      @game.player1 = Player.new(player_symbols[0])
      @game.player2 = Player.new(player_symbols[1])
    else
      @game.initialize_players(session[:current_turn] || 'X')
    end

    # Restaurar el turno actual
    if session[:current_turn]
      @game.current_turn = [@game.player1, @game.player2].find { |player| player.symbol == session[:current_turn] }
    end
  end
end