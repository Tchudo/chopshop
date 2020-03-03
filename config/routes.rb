Rails.application.routes.draw do

  devise_for :users
  root to: 'searches#new'


  resources :stocks, only:[:index, :show], shallow: true do
    resources :reviews, only:[:show, :new, :create]
    resources :favorites, only:[:create]
    resources :baskets, only:[:create]

  end
  resources :favorites, only:[:index, :destroy]
  resources :baskets, only:[:index, :destroy]
  resources :itinaries, only: [:index]
end
