Rails.application.routes.draw do
  resources :cards

  root "home#index"
  put "review_card" => "home#review_card"
end
