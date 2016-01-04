class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.belongs_to :merchant, index: true, foreign_key: true
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
