Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get 'customers/unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw', as: 'withdraw'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/edit' => 'customers#edit', as: 'edit'
    patch 'customers' => 'customers#update', as: 'update'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show, :update]
    resources :cart_items, only: [:index, :update, :destroy, :create] do 
      collection do
        delete 'destroy_all'
      end
    end
    post 'orders/confirm' => 'orders#confirm', as: 'comfirm'
    get 'orders/complete' => 'orders#complete', as: 'complete'
    resources :orders, only: [:new, :create, :index, :show,]
  end

  namespace :admin do
    resources :genres, only: [:index, :create, :update, :edit]
    resources :items, only: [:new, :show, :index, :create, :update, :edit]
    resources :customers, only: [:index, :show, :edit, :update]
    root to: "homes#top"
    resources :order_details, only: [:index, :show, :update]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
