Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'items#index'

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'users/my_page' => 'users#show'
  get 'users/confirm' => 'users#confirm'
  patch 'users/unsubscribe' => 'users#subscribe', as: 'users/unsubcribe'
  get 'items/search', to: 'items#search', as: 'search_items'
  
  resources :users, only: [:index, :edit, :update]
  resources :items, only: [:index, :show]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :reviews
  
  devise_for :users
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
