class RemoveCreditCardExpitaionDateFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :credit_card_expiration_date
  end
end
