Rails.application.routes.draw do
  get 'welcome/index'
  get 'home/index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :users, :sessions, :posts

  root to: 'welcome#index'

end
