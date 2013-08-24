ASCIIRubyTron::Application.routes.draw do
  root 'battlefield#index'

  post 'make_move' => 'battlefield#make_move'
end
