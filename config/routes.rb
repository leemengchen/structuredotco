Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'landing#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
