Rails.application.routes.draw do
  
  root to: "homes#top"
  get 'home/about' => 'layouts#about'
  devise_for :books
  devise_for :users
  resources :users, onry: [:show, :edit, :update]
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
