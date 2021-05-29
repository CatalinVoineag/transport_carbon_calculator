Rails.application.routes.draw do
  root to: 'carbon_calculator#index'
  post '/calculate', to: 'carbon_calculator#calculate'
end
