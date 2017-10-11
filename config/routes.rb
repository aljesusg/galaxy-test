Rails.application.routes.draw do
  get 'welcome/info',  as: 'info'
  get 'welcome/help',  as: 'help'
  get 'welcome/about', as: 'about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#info'
  devise_for :users
  resources :users, only: [:show]
  resources :offsprings do
    resources :assignments, except: [:index, :show]
  end
  resources :rooms, only: [:index]
  resources :shifts, only: [:show]

  namespace :admin do
    resources :users, only: [:index]
    resources :offsprings, only: [:index]
    resources :rooms, only: [:index]
    resources :shifts, only: [:show]
  end
end
