Rails.application.routes.draw do
  match '/checkout_atos',          :as => :atos_checkout,          :to => 'checkout#atos'
  match '/checkout_cancel_atos',   :as => :cancel_atos_checkout,   :to => 'checkout#cancel_atos',   :via => :post
  match '/checkout_complete_atos', :as => :complete_atos_checkout, :to => 'checkout#complete_atos', :via => :post
  
  namespace :atos do
    resources :payment_notifications, :only => :create
  end
end
