Rails.application.routes.draw do
  root to: "shortlinks#new"

  resources :shortlinks, only: :create
end
