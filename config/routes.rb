Rails.application.routes.draw do
  get 'welcome/index'
  get 'home/index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'tags/:tag', to: 'home#index', as: :tag

  resources :users, :sessions, :posts

  resources :users do
    resources :groups
  end
  
  resources :account_activations, only: :edit

  root to: 'welcome#index'

end
