Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  resources :articles, only: [:index, :new, :create, :update, :show] do
    resources :comments, only: [:create] 
  end
  get 'articles' => 'articles#search'
  resources :articles, only: [:edit] do
    resources :articles, only: [:destroy]
  end

  resources :users, only: [:show]
end
