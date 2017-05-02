Rails.application.routes.draw do
  get 'orders/show'

  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    confirmations: 'users/confirmations',
                                    shared: 'users/shared' }
  resources :users, only: :show

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
  root to: "items#index"
  namespace :admin do
    resources :categories do
      resources :items
    end
    resources :items
  end
  resources :items, only: %i[index show]

  resources :categories, only: %i[index show] do
    resources :items, only: %i[index show]
  end
  resource :cart, only: [:show]
  resources :order_items, only: %i[create update destroy]
  resources :orders, only: %i[index show]
end
