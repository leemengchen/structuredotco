Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'landing#index'
  get :about, to: 'about#aboutpage'
  get :items, to: 'items#index'
  get :faq, to: 'faq#index'

  get :'cart/show', to: "cart#show"
  post :add_item, to: "cart#add_item"
  delete :remove_item, to: "cart#remove_item"
  patch :update_item, to: "cart#update_item"

  get :order, to: "order#new"
  post :checkout, to: "order#checkout"

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user, only: [:destroy] do
  #   delete 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
