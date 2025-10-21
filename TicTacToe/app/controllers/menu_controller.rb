class MenuController < ApplicationController
  def index
  end

  def start_game
    # player_symbol = params[:player_symbol]
    # session[:player_symbol] = player_symbol

    # @board = Board.new
    # @board.initialize_board
    # session[:board] = @board.board

    # redirect_to game_path, notice: "El juego ha comenzado. Juegas como '#{player_symbol}'."
    @game = Game.new
    @game.initialize_board
    @game.initialize_players(params[:player_symbol])
    session[:board] = @game.board.board
    session[:current_turn] = @game.current_turn.symbol
    redirect_to game_path, notice: "El juego ha comenzado. Juegas como '#{@game.current_turn.symbol}."
  end

  def game
    @game = Board.new
    @game.initialize_board
    @game.board.instance_variable_set(:@board, session[:board])
    @board = @game.board
    @current_turn = session[:current_turn]
  end
end