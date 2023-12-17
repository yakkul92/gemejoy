Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'items#index'
  
  devise_for :users
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  delete 'users/unsubscribe/:id' => 'users#unsubscribe', as: 'users_unsubscribe'
  
  get 'items/search', to: 'items#search', as: 'search_items'
  
  resources :users, only: [:index, :show, :edit, :update]

  resources :items, only: [:index, :show] do
    resource :favorite_items, only: [:create, :destroy]
  end
  resources :genres, only: [:index, :create, :edit, :update]
  resources :reviews do
    resource :favorite_reviews, only: [:create, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
