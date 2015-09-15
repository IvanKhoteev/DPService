Rails.application.routes.draw do
  root 'trade_objects#index'

  resources :trade_objects do
    resources :sales_histories
  end
  resources :strategies do
    resources :rules
    resources :schedule_rules
  end

end
