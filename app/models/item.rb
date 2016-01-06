class Item < ActiveRecord::Base
  before_save :convert_unit_price

  default_scope {order("ID ASC")}

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def convert_unit_price
    self.unit_price = self.unit_price.to_i / 100.0
  end
end
