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

  def self.total_revenue(params)
    Invoice.successful.where(created_at: params[:date]).joins(:invoice_items).sum("unit_price * quantity")
  end

  def favorite_customer
    customers = invoices.successful.group(:customer_id).count
    customers.max_by(1){|customer| customer[1]}.first[0]
  end

  def customers_with_pending_invoices
    ids = invoices.failed.pluck(:customer_id).uniq
    ids.map do |id|
      Customer.find(id)
    end
  end

  #
  # def self.most_revenue(params)
  #   if params[:date]
  #     invoices.successful.where(created_at: params[:date]).joins(:invoice_items).sum("unit_price * quantity")
  #   else
  #   merchants = Invoice.successful.joins(:invoice_items).group(:merchant_id, ("unit_price * quantity")).count
  #   # binding.pry
  #   top_merchants = merchants.max_by(params[:quantity].to_i){|array, count| array[1]}
  #   top_merchants.map do |data, count|
  #     Merchant.find(data[0])
  #   end
  #   end
  # end
end
