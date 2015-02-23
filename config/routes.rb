Rails.application.routes.draw do
  resources :cards
  root 'home#index'
end
