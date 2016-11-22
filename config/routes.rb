Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :subscription_intervals do
      collection do
        get :search
      end
    end
    resources :subscriptions, :except => [:new,:create]
    resources :check_orders, only: [:index] do
      collection do
        post :confirm
      end
    end
  end

  resources :subscriptions, :only => [:destroy]

end
