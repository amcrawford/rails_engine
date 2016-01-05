require 'csv'

namespace :import_data do
 desc "Import the CSV files into models in our DB."
 task :import => :environment do
   customers = File.read("#{Rails.root}/lib/assets/customers.csv")
   customers_csv  = CSV.parse(customers, headers:true)

   customers_csv.each do |row|
     Customer.create(row.to_hash)
   end

   merchants = File.read("#{Rails.root}/lib/assets/merchants.csv")
   merchants_csv  = CSV.parse(merchants, headers:true)

   merchants_csv.each do |row|
     Merchant.create(row.to_hash)
   end

   items = File.read("#{Rails.root}/lib/assets/items.csv")
   items_csv  = CSV.parse(items, headers:true)

   items_csv.each do |row|
     Item.create(row.to_hash)
   end

   invoices = File.read("#{Rails.root}/lib/assets/invoices.csv")
   invoices_csv  = CSV.parse(invoices, headers:true)

   invoices_csv.each do |row|
     Invoice.create(row.to_hash)
   end

   transactions = File.read("#{Rails.root}/lib/assets/transactions.csv")
   transactions_csv  = CSV.parse(transactions, headers:true)

   transactions_csv.each do |row|
     Transaction.create(row.to_hash.except!("credit_card_expiration_date"))
   end

   invoice_items = File.read("#{Rails.root}/lib/assets/invoice_items.csv")
   invoice_items_csv  = CSV.parse(invoice_items, headers:true)

   invoice_items_csv.each do |row|
     InvoiceItem.create(row.to_hash)
   end
   end
 end
