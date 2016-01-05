Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, default: {format: :json} do
        collection do
          get :find
          get :find_all
        end
      end

      resources :invoice_items, default: {format: :json} do
        collection do
          get :find
          get :find_all
        end
      end

      resources :invoices, default: {format: :json} do
        collection do
          get :find
          get :find_all
        end
      end

      resources :items, default: {format: :json} do
        collection do
          get :find
          get :find_all
        end
      end

      resources :merchants, default: {format: :json} do
        collection do
          get :find
          get :find_all
        end
      end

      resources :transactions, default: {format: :json} do
        collection do
          get :find
          get :find_all
        end
      end
    end
  end
end
