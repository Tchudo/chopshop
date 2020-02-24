Rails.application.routes.draw do
  get 'searches/new'
  get 'reviews/new'
  get 'reviews/create'
  get 'favorites/index'
  get 'favorites/create'
  get 'stocks/index'
  get 'stocks/show'
  get 'search/new'
  devise_for :users
  root to: 'search#new'

  resources :stocks, only:[:index, :show], shallow: true do
    resources :favorites, only:[:index, :create], shallow:true
    resources :reviews, only:[:new, :create], shallow:true
  end


end
