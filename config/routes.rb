Rails.application.routes.draw do
  get 'git_hub_repos/show'

  get 'git_hub_repos/refresh'

  get 'welcome/info',  as: 'info'
  get 'welcome/help',  as: 'help'
  get 'welcome/about', as: 'about'
  get '/auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#info'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # config/routes.rb

  resources :users, only: [:show] do
    resources :git_hub_repos, only: [:index] do
      collection do
        post :refresh
        post :clean
      end
    end
  end

  resources :git_hub_repos, only: [:show]

  namespace :admin do
    resources :users, only: [:index]
  end
end
