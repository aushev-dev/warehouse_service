Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :products
  put 'sell', to: 'products#sell'
  put 'transfer', to: 'products#transfer'

end
