Rails.application.routes.draw do
  root to: 'landing#index'
  get :about, to: 'about#aboutpage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
