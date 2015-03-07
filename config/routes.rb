Rails.application.routes.draw do
  root "home#index"
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider

  get "review" => "review#index"

  get "login" => "sessions#new"
  put "review_card" => "review#review_card"
  post "logout" => "sessions#destroy", as: :logout

  resources :profile, only: [:edit, :update]
  resources :registration, only: [:new, :create]
  resources :sessions
  resources :decks do
    resources :cards
    member do
      put "set_current"
    end
  end
end
