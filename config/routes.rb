Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end
      resources :merchants, only: [:index, :show]
      
      namespace :customers do
        get '/find', to: 'search#show'
      end
      
      resources :customers, only: [:show]
    end
  end

  # namespace :api do
  #   namespace :v1 do
  #     resources :customers, only: [:show]
  #   end
  # end
end

