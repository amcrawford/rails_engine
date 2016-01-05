class Item < ActiveRecord::Base
  before_save :convert_unit_price

  belongs_to :merchant

  def convert_unit_price
    self.unit_price = self.unit_price.to_i / 100.0
  end
end
