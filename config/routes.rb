Rails.application.routes.draw do
  root to: 'properties#index'
  resources :properties do
    collection do
      post :confirm
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
