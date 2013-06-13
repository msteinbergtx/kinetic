Kinetic::Application.routes.draw do
  devise_for :users

  resources :rules, only: [:new, :create, :index, :edit, :show, :update]

  root to: 'home#index'
end
