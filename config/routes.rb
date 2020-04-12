Rails.application.routes.draw do
  resources :authors, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :gossips do
  	resources :comments
    resources :likes, only: [:create, :destroy]
  end
  resources :comments do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :conversations, only: [:index, :create] do
    resources :private_messages, only: [:index, :new, :create]
  end
  resources :cities, only: :show
  resources :profiles, only: :show
  get 'contact',       to: 'static_pages#contact'
  get 'team',          to: 'static_pages#team'
  get 'welcome/:name', to: 'static_pages#welcome'
  root                     'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
