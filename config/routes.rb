Rails.application.routes.draw do
  resources :cards

  root 'home#index'
  post 'home' => 'home#check_answer'
end
