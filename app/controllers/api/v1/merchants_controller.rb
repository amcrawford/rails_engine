class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params).all
  end

  def random
    respond_with Merchant.order("RANDOM()").first
  end

  def items
    respond_with Merchant.find(params[:id]).items
  end

  def invoices
    respond_with Merchant.find(params[:id]).invoices
  end

  def revenue
    respond_with revenue: Merchant.find(params[:id]).find_revenue(params)
  end

  def favorite_customer
    respond_with id: Merchant.find(params[:id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find(params[:id]).customers_with_pending_invoices
  end

  def most_revenue
    respond_with Merchant.most_revenue(params)
  end

  private

    def merchant_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
