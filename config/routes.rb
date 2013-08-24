ASCIIRubyTron::Application.routes.draw do
  root 'battlefield#index'

  post 'make_move' => 'battlefield#make_move'
  get 'quit_game' => 'battlefield#quit_game', as: 'quit_game'
  get 'start_game' => 'battlefield#start_game', as: 'start_game'
end
