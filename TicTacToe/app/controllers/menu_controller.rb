class MenuController < ApplicationController
  def index
    @player_symbol = session[:player_symbol] || 'X'
    @game_mode = session[:game_mode] || 'local'
  end
end