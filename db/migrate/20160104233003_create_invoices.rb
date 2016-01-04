class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :merchant, index: true, foreign_key: true
      t.string :status
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
