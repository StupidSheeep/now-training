Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :user,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords],controllers: {
    sessions: "admin/sessions"
  }

    scope module: :public do
    root :to => "homes#top"
    get "about", to: "homes#about"
    get "users/my_page/:id", to: "users#show", as: "users_my_page"
    get "users/my_page/edit/:id", to: "users#edit", as: "users_my_page_edit"
    patch "users/my_page/edit/:id", to: "users#update"
    get "users/check", to: "users#check"
    patch "users/withdrawal", to: "users#withdrawal"
    get "user", to: "users#index"


    resources :posts do
      resources :comments,only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end
    resources :relationships, only: [:create, :destroy]
      post 'follow', to: 'relationships#create', as: 'follow_user'
      delete 'unfollow', to: 'relationships#destroy', as: 'unfollow_user'

  end

  namespace :admin do
    root :to =>  'homes#top'
    resources :users do
      member do
        patch 'toggle_status'
      end
    end
    resources :posts
    resources :genres
    resources :comments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
