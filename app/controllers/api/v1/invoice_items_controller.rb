class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def find
    respond_with InvoiceItem.find_by(invoice_item_params)
  end

  def find_all
    respond_with InvoiceItem.where(invoice_item_params).all
  end

  def random
    respond_with InvoiceItem.order("RANDOM()").first
  end

  private

    def invoice_item_params
      params.permit(:id, :item_id, :invoice_id, :quantity, :created_at, :updated_at)
    end
end
