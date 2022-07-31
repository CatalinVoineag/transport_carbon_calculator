Rails.application.routes.draw do
  resources :carbon_calculations, only: [:index, :new, :create]
  root to: 'carbon_calculations#new'
end
