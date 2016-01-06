class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants = invoices.successful.group(:merchant_id).count
    merchant = merchants.max_by(1){|merchant| merchant[1]}.first[0]
    Merchant.find(merchant)
  end
end
