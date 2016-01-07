ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require "simplecov"

SimpleCov.start("rails")


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def json_response
    JSON.parse(response.body)
  end

  def create_merchant_items
    merchant = Merchant.first
    merchant.items.create(name: "thing1", description: "stuff things do")
  end

  def create_merchant_invoices
    merchant = Merchant.first
    merchant.invoices.create(customer_id: Customer.first.id, status: "Completed", created_at: "2016-01-06T22:31:30.372Z")
    merchant.invoices.create(customer_id: Customer.first.id, status: "Not Completed", created_at: "2015-01-06T22:31:30.372Z")
  end

  def create_customer_invoices
    customer = Customer.first
    customer.invoices.create(merchant_id: Merchant.first.id, status: "Completed", created_at: "2016-01-06T22:31:30.372Z")
  end

  def create_customer_invoice_items
    create_customer_invoices
    Customer.first.invoices.first.invoice_items.create(item_id: Item.first.id, quantity: 3, unit_price: 200)
  end

  def create_customer_transactions
    invoice = Customer.first.invoices.first
    invoice.transactions.create(credit_card_number: "333", created_at: "2016-01-06T22:31:30.372Z", result: "success")
  end

  def create_invoice_transactions
    invoice = Invoice.first
    invoice.transactions.create(credit_card_number: "333", created_at: "2016-01-06T22:31:30.372Z", result: "success")
  end

  def create_invoice_items
    invoice = Invoice.first
    invoice.invoice_items.create(item_id: Item.first.id, quantity: 3)
  end
end

class ActionController::TestCase

end
