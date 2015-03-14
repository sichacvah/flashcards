Rails.application.routes.draw do
  root "home#index"
  scope :home, module: "home" do
    resources :registration, only: [:new, :create]
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback"
    get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  end

  scope :dashboard, module: "dashboard" do
    get "review" => "review#index"
    get "login" => "sessions#new"
    put "review_card" => "review#review_card"
    post "logout" => "sessions#destroy", as: :logout
    resources :profile, only: [:edit, :update]
    resources :sessions
    resources :decks do
      resources :cards
      member do
        put "set_current"
      end
    end
  end
end
