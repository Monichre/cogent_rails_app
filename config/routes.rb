Rails.application.routes.draw do
  get 'welcome/index'
  get 'home/index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'tags/:tag', to: 'home#index', as: :tag

  resources :users, :sessions, :posts
  resources :account_activations, only: :edit

  resources :users do
    resources :groups do
      resources :invitations, only: [:new, :create]
    end
  end

  root to: 'welcome#index'

end
