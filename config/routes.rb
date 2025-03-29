Rails.application.routes.draw do

  root to: "homes#top"
  get "home/about" =>"homes#about",as: "about"

  devise_for :users#下に書くとusersコントローラーにオーバーロードされsign_inページに遷移できなくなるので注意！！

  resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
