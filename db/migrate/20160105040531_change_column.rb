class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :items, :unit_price, :decimal
  end
end
