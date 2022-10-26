Rails.application.routes.draw do
  root 'welcome#index'

  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :employees #, except: [:new]
end
