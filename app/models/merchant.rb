class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def find_revenue(params)
    if params[:date]
      invoices.successful.where(created_at: params[:date]).joins(:invoice_items).sum("unit_price * quantity")
    else
      invoices.successful.joins(:invoice_items).sum("unit_price * quantity")
    end
  end

  def favorite_customer
    customers = invoices.successful.group(:customer_id).count
    customers.max_by(1){|customer| customer[1]}.first[0]
  end

  def customers_with_pending_invoices
    invoices.failed.group(:customer_id).count
  end

  # def most_revenue#(params)
  #   # if params[:date]
  #   #   invoices.successful.where(created_at: params[:date]).joins(:invoice_items).sum("unit_price * quantity")
  #   # else
  #     Merca.successful.joins(:invoice_items).sum("unit_price * quantity")
  #   # end
  # end
end
