Rails.application.routes.draw do
  devise_for :users

  resources :products do
    resources :comments, only: [:create, :update, :destroy]
  end

  root to: "products#index"  
end
