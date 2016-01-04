class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.belongs_to :item, index: true, foreign_key: true
      t.belongs_to :invoice, index: true, foreign_key: true
      t.integer :quantity
      t.integer :unit_price
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
