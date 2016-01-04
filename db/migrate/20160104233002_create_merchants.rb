class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
