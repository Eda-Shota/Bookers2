Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get  "/homes/about", to: "homes#about", as: "about"
  resources :users, only: [:index, :show, :edit, :update]
  resources :books
end
