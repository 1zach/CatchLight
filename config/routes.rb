Rails.application.routes.draw do
  root to: "pages#home"
  get "/about_us" => "pages#about_us"

  devise_for :users
  resources :users, only: :show
  resources :photos do
    resources :bookmarks
  end
end
