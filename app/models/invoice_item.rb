class InvoiceItem < ActiveRecord::Base
  before_save :convert_unit_price

  belongs_to :item
  belongs_to :invoice

  def convert_unit_price
    self.unit_price = self.unit_price.to_i / 100.0
  end
end
