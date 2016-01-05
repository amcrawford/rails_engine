class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    respond_with Invoice.find_by(invoice_params)
  end

  def find_all
    respond_with Invoice.where(invoice_params).all
  end

  def random
    respond_with Invoice.order("RANDOM()").first
  end

  def transactions
    respond_with Invoice.find(params[:id]).transactions
  end

  def invoice_items
    respond_with Invoice.find(params[:id]).invoice_items
  end

  def items
    respond_with Invoice.find(params[:id]).items
  end

  def customer
    respond_with Invoice.find(params[:id]).customer
  end

  def merchant
    respond_with Invoice.find(params[:id]).merchant
  end

  private

    def invoice_params
      params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
    end
end
