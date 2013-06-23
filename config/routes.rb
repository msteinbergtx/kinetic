Kinetic::Application.routes.draw do
  devise_for :users

  resources :rules, only: [:new, :create, :index, :edit, :show, :update]
  resources :organizations, only: [:new, :create, :index, :edit, :update]
  resources :deals, only: [:new, :create, :index, :calculate] do
    member do
      post :calculate
    end
  end

  root to: 'home#index'
end
