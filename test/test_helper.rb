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
    merchant.invoices.create(customer_id: Customer.first.id, status: "Completed")
  end
end

class ActionController::TestCase

end

# DatabaseCleaner.strategy = :transaction
#
# class Minitest::Spec
#   def setup
#     DatabaseCleaner.start
#   end
#
#   def teardown
#     DatabaseCleaner.clean
#   end
# end
