Rails.application.routes.draw do
  # Menu route
  root to: 'menu#index'

  get '/game', to: 'game#game', as: 'game'
  
  post '/start_game', to: 'game#start_game', as: 'start_game'
  post '/make_move', to: 'game#make_move', as: 'make_move'
end
