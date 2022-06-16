Rails.application.routes.draw do
  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end

  devise_for :users
  root 'homes#index'

  resources :homes do
    collection do
      get :wallet_history
    end
  end

  resources :deposits
  resources :stocks
  resources :transfers
  resources :withdraws
end
