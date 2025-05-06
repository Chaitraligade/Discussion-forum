Rails.application.routes.draw do
  # Swagger API Documentation
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # Devise Authentication
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # Moderator Dashboard
  authenticate :user, ->(u) { u.moderator? } do
    get 'moderator', to: 'moderators#dashboard'
  end

  namespace :moderator do
    get "dashboard", to: "dashboard#index", as: "dashboard"
  end

  # Health Check Route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root Route
  root "discussion_threads#index"

  # Discussion Threads (Public Web)
  resources :discussion_threads, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end

  resources :users, only: [:show]

  # API Routes
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions' }

      resources :users, only: [:index, :destroy] do
        collection do
          get 'profile'
          put 'update'
          put 'change_password'
        end
      end

      # Discussion Threads API
      resources :discussion_threads, only: [:index, :show, :create, :update, :destroy] do
        resources :subthreads, only: [:index, :create]
        resources :comments, only: [:create]
      end

      # Admin & Moderator API Routes
      namespace :admin do
        resources :users, only: [:index, :update, :destroy]
      end

      namespace :moderator do
        resources :users, only: [:index, :update]
      end
    end
  end
  resources :thread_chats, only: [:index, :show, :create]
  # resources :messages, only: [:create]
  
 
  mount ActionCable.server => '/cable'

  resources :messages, only: [:index, :create]
  # resources :notifications, only: [:index] do
  #   member do
  #     patch :mark_as_read
  #   end
  # end

  resources :notifications, except: [:show] do
    # collection do
    #   patch :mark_all_as_read
    # end
  
    member do
      patch :mark_as_read
    end
  end
  resources :discussion_threads do
    resources :likes, only: [:create, :destroy]
  end
  
end
