class GameController < ApplicationController
  before_action :load_game_from_session, only: [:game, :make_move]

  def start_game
    @game = Game.new
    @game.initialize_board
    @game.initialize_players(params[:player_symbol])
    GameSessionService.new(session, @game).save_state_after_start
    session[:player_symbol] = params[:player_symbol].presence || session[:player_symbol] || 'X'
    session[:game_mode] = params[:game_mode].presence || session[:game_mode] || 'local'
    if session[:game_mode].to_s == 'ai'
      human_symbol = session[:player_symbol]
      if human_symbol != @game.current_turn.symbol
        ai = AIPlayer.new
        ai.initialize_player(@game.current_turn.symbol)
        ai_move = ai.find_best_move(@game.board)
        if ai_move
          result = @game.make_move(ai_move)
          GameSessionService.new(session, @game).save_result(result)
        end
      end
    end

    redirect_to game_path, notice: "El juego ha comenzado. Juegas como '#{@game.current_turn.symbol}'. Modo: #{session[:game_mode]}"
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

      if session[:game_mode].to_s == 'ai' && !GameSessionService.new(session, @game).game_finished? && @game.instance_variable_get(:@current_turn).is_a?(AiPlayer)
        ai_move = @game.instance_variable_get(:@current_turn).find_best_move(@game.board)
        if ai_move
          ai_result = @game.make_move(ai_move)
          GameSessionService.new(session, @game).save_result(ai_result)
          flash[:notice] = ai_result[:message]
        end
      end

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

    # Rebuild players according to session state and game mode (local or ai)
    human_symbol = session[:player_symbol] || 'X'
    opponent_symbol = human_symbol == 'X' ? 'O' : 'X'

    # Create player objects
    human = Player.new
    human.initialize_player(human_symbol)

    if session[:game_mode].to_s == 'ai'
      ai = AiPlayer.new
      ai.initialize_player(opponent_symbol)
      opponent = ai
    else
      opponent = Player.new
      opponent.initialize_player(opponent_symbol)
    end

    # Determine current turn symbol saved in session (who should play next)
    current_symbol = session[:current_turn] || human_symbol

    # Assign players so that @player1 has the current turn
    if current_symbol == human_symbol
      @game.instance_variable_set(:@player1, human)
      @game.instance_variable_set(:@player2, opponent)
      @game.instance_variable_set(:@current_turn, human)
    else
      @game.instance_variable_set(:@player1, opponent)
      @game.instance_variable_set(:@player2, human)
      @game.instance_variable_set(:@current_turn, opponent)
    end
  end
end