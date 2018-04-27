Rails.application.routes.draw do
  root to: "shortlinks#new"

  resources :shortlinks, only: :create

  get "/:slug" => "shortlinks#find_and_redirect"
end
