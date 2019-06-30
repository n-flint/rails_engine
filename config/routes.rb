Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'date_revenue#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoice#index'
        get '/:id/transactions', to: 'transaction#index'
        get '/:id/favorite_merchant', to: 'favorite#show'
      end
      resources :customers, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
      end
      resources :transactions, only: [:index, :show]

      namespace :items do
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#show'
      end
      resources :items, only: [:show]

      namespace :invoice_items do
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item', to: 'item#show'
      end

      namespace :invoices do
        get '/:id/transaction', to: 'transaction#index'
        get '/:id/invoice_items', to: 'invoice_item#index'
        get '/:id/items', to: 'item#index'
        get '/:id/customer', to: 'customer#show'
        get '/:id/merchant', to: 'merchant#show'
      end
    end
  end
end

