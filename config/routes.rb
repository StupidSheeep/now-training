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
    get "users/my_page/:id", to: "users#show"
    get "users/my_page/edit", to: "users#edit"
    patch "users/my_page", to: "users#update"
    get "users/check", to: "users#check"
    patch "users/withdrawal", to: "users#withdrawal"


    resources :posts
    resources :comments
    resources :bookmarks
    resources :relationships
  end

  namespace :admin do
    root :to =>  'homes#top'
    resources :users
    resources :posts
    resources :genres
    resources :comments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
