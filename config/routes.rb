Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :users, only: :show

  resources :photos do
    member do
      post "toggle_favorite", to: "photos#toggle_favorite"
    end
  end
end
