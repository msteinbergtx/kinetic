Kinetic::Application.routes.draw do
  devise_for :users

  resources :rules, only: [:new, :create, :index, :edit, :show, :update]
  resources :organizations, only: [:new, :create, :index, :edit, :update]
  resources :deals, only: [:new, :create, :index, :calculate, :schedule, :associate] do
    member do
      post :associate
      post :calculate
      post :schedule
    end
  end

  root to: 'home#index'
end
