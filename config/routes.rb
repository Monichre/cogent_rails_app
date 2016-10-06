Rails.application.routes.draw do
  get 'welcome/index'
  get 'home/index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'tags/:tag', to: 'home#index', as: :tag
  get 'invitation_signup/:invitation_token', to: 'account_activations#new', as: 'invitation_signup'

  resources :users, :sessions, :posts
  resources :account_activations, only: [:edit, :create]

  resources :users do
    resources :groups do
      resources :invitations, only: [:new, :create]
    end
  end

  root to: 'welcome#index'

end
