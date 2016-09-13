require 'sidekiq/web'

Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :projects
  resources :packages

  get '/projects/new/github' => 'projects#new_github', as: :new_github
  get '/projects/new/npm' => 'projects#new_npm', as: :new_npm

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
