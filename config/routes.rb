Rails.application.routes.draw do
  devise_for :users, :path => 'accounts'

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :photos 
    resources :bookmarks
  end
    resources :photos, only: :destroy
    resources :bookmarks, only: :destroy
  
  # resources :photos do
  #   resources :bookmarks
  # end
  #   resources :bookmarks, only: [:destroy]
  
  # Defines the root path route ("/")
  # root "articles#index"
end
