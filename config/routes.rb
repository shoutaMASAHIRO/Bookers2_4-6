Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"
  get "search" => "searches#search"


  devise_for :users

  resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
    resources :book_comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following
      get :followers
    end
  end

  resources :relationships, only: [:create, :destroy]  
end
