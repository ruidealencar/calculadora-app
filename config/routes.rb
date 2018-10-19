Rails.application.routes.draw do
  get 'calculadora/index'
  get 'calculadora/calcular'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to:'calculadora#index'
end
