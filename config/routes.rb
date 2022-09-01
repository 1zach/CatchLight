Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  resources :users, only: :show

  resources :photos , except: [:edit, :update] do
    member do
      post "toggle_favorite", to: "photos#toggle_favorite"
    end


  end
  get "/about_us" => "pages#about_us"
end
