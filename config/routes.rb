Rails.application.routes.draw do

  devise_for :users
 root to: 'searches#new'

  get "searches/new", to: 'searches#new'
  resources :searches, only:[:new], shallow: true do
    resources :stocks, only:[:index, :show], shallow: true do
      resources :reviews, only:[:show, :new, :create]
      resources :favorites, only:[:create]
    end
  end
  resources :favorites, only:[:index, :destroy]
end
