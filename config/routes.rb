Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, defaults: {format: :json} do
        collection do
          get :find
          get :find_all
          get :random
        end

        member do
          get :invoices
          get :transactions
          get :favorite_merchant
        end
      end

      resources :invoice_items, defaults: {format: :json} do
        collection do
          get :find
          get :find_all
          get :random
        end

        member do
          get :invoice
          get :item
        end
      end

      resources :invoices, defaults: {format: :json} do
        collection do
          get :find
          get :find_all
          get :random
        end

        member do
          get :transactions
          get :invoice_items
          get :items
          get :customer
          get :merchant
        end
      end

      resources :items, defaults: {format: :json} do
        collection do
          get :find
          get :find_all
          get :random
        end

        member do
          get :invoice_items
          get :merchant
        end
      end

      resources :merchants, defaults: {format: :json} do
        collection do
          get :find
          get :find_all
          get :random
          get :most_revenue
          get :revenue, to: "merchants#total_revenue"
        end

        member do
          get :items
          get :invoices
          get :revenue
          get :favorite_customer
          get :customers_with_pending_invoices
        end
      end

      resources :transactions, defaults: {format: :json} do
        collection do
          get :find
          get :find_all
          get :random
        end

        member do
          get :invoice
        end
      end
    end
  end
end
