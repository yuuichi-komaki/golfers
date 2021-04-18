Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  resources :users, only: [:show, :index, :edit, :update, :destroy]
  resources :courses, only: [:new, :create, :index, :show, :destroy]
  get 'prefecture_courses', to: 'courses#prefecture_courses'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
