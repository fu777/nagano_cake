Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only: [:index, :create, :update, :edit]
  end
  
  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get 'customers/unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw', as: 'withdraw'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    resources :customers, only: [:edit, :update]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
