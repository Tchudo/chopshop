Rails.application.routes.draw do

  devise_for :users
  root to: 'searches#new'


  resources :stocks, only:[:index, :show], shallow: true do
    resources :reviews, only:[:new, :create]
  end
  resources :favorites, only:[:index, :create]
end
