Rails.application.routes.draw do


  namespace :admin do
    get 'top'=>'homes#top'
    resources :genres, only: [:update, :create, :index, :edit]
    resources :items, :except => :destroy
    resources :customers, only: [:update, :index, :edit, :show]
    resources :orders, only: [:show]
  end
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :addresses, :except => [:show, :new]
    resources :items, only:[:show, :index]
    post 'orders/confirm' => 'orders#confirm'
    resources :orders, only:[:show, :index, :create, :new]
    get 'orders/thanks' => 'orders#thanks'
    resources :cart_items, only:[:update, :index, :create, :destroy]
    delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    resource :customers, only: [:update, :show, :edit]
    get 'customers/confirm' => 'customers#confirm', as: 'customers_confirm'
    patch 'customers/cancellation' => 'customers#cancellation', as: 'customers_cancellation'
  end
  devise_for :admins
  devise_for :customers
end
