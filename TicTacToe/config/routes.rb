Rails.application.routes.draw do
  # Menu route
  root to: 'menu#index'
  get 'game', to: 'menu#game'
  post 'start_game', to: 'menu#start_game'
end
