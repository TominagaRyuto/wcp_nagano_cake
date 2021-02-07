Rails.application.routes.draw do
  namespace :admin do
  resources :genres, only: [:update, :create, :index, :edit]
  resources :items, :except => :destroy

end
  devise_for :customers
  devise_for :admins
  root to: 'homes#top'
  get 'about' => 'homes#about'
end
