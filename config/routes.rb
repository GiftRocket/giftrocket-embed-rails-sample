Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  root :to => 'home#index'

  resources :rewards, only: [:new, :show, :update] do
    collection do
      post :webhook
    end

    member do
      post :error
    end
  end
end
