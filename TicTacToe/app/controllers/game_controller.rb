class GameController < ApplicationController
  def start_game
    @game = Game.new
    @game.initialize_board
    @game.initialize_players(params[:player_symbol])
    session[:board] = @game.board.board
    session[:current_turn] = @game.current_turn.symbol
    redirect_to game_path, notice: "El juego ha comenzado. Juegas como '#{@game.current_turn.symbol}'."
  end

  def game
    @game = Game.new
    @game.initialize_board
    @board = @game.board
    @game.board.instance_variable_set(:@board, session[:board])
    @current_turn = session[:current_turn]
  end

  def make_move
    begin
      @game = Game.new
      @game.initialize_board
      @game.board.instance_variable_set(:@board, session[:board])
      @game.initialize_players(session[:current_turn])
      @game.make_move(params[:cell_index].to_i)
      session[:board] = @game.board.board
      session[:current_turn] = @game.current_turn.symbol
      redirect_to game_path, notice: "Turno de '#{@game.current_turn.symbol}'."
    rescue InvalidLocation, InvalidMovement => e
      flash[:alert] = e.message
      redirect_to game_path
    end
  end
end