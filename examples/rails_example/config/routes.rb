Rails.application.routes.draw do
  mount Books::API => '/api'

  resources :applications
  resources :libraries
  resources :authors
  resources :books

  root 'libraries#index'

  get 'switch-environments', to: 'sandbox#edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
