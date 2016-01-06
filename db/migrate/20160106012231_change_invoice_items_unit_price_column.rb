class ChangeInvoiceItemsUnitPriceColumn < ActiveRecord::Migration
  def change
    change_column :invoice_items, :unit_price, :decimal
  end
end
