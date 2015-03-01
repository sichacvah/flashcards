Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :cards
  resources :sessions
  resources :users

  root "home#index"
  get "login" => "sessions#new"
  get "review" => "review#index"
  put "review_card" => "review#review_card"
  post "logout" => "sessions#destroy", :as => :logout
end
