Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :follows, only: [ :index, :create, :destroy]
  end
  resources :tweets
  resources :likes
  resources :replies
end
