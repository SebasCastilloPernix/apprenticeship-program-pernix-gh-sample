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

  def reset
    GameSessionService.new(session, nil).reset!
    redirect_to root_path, notice: "Juego reiniciado. Selecciona quién jugará como 'X' u 'O'."
  end

  private

  def load_game_from_session
    @game = Game.new
    @game.initialize_board
    @game.board.instance_variable_set(:@board, session[:board]) if session[:board]
    @game.initialize_players(session[:current_turn] || 'X')
  end
end