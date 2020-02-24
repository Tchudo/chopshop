Rails.application.routes.draw do

  devise_for :users
  get "/searches", to: 'searches#new'

  resources :stocks, only:[:index, :show], shallow: true do
    resources :favorites, only:[:index, :create], shallow:true
    resources :reviews, only:[:new, :create], shallow:true
  end


end
