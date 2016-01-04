class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
