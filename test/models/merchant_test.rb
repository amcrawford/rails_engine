require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "#find_revenue accepts a date and returns correct data" do
    create_customer_invoices
    create_customer_transactions
    create_customer_invoice_items
    invoice = Merchant.first.find_revenue(date: "2016-01-06T22:31:30.372Z")

    assert_equal 6, invoice.to_i
  end

  test "#find_revenue returns correct data without date" do
    create_customer_invoices
    create_customer_transactions
    create_customer_invoice_items
    invoice = Merchant.first.find_revenue(id: Merchant.first.id)

    assert_equal 6, invoice.to_i
  end
end
