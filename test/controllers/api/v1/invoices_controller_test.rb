require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of items" do
    get :index, format: :json
    assert_equal Invoice.count, json_response.count
  end

  test "#index contains invoices that have the correct properties" do
    get :index, format: :json

    json_response.each do |invoice|
      assert invoice["status"]
      assert invoice["created_at"]
    end
  end

  test "#show response to json" do
    get :show, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Invoice.first.id
    assert_kind_of Hash, json_response
  end

  test "#show returns the correct invoice" do
    get :show, format: :json, id: Invoice.first.id
    assert_equal Invoice.first.id, json_response["id"]
  end

  test "#find responds to json" do
    get :find, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test "#find returns one record" do
    get :find, format: :json, id: Invoice.first.id
    assert_kind_of Hash, json_response
  end

  test "#find returns the correct invoice" do
    get :find, format: :json, id: Invoice.first.id
    assert_equal Invoice.first.id, json_response["id"]
  end

  test "#find returns the correct invoice using status" do
    get :find, format: :json, status: Invoice.first.status
    assert_equal Invoice.first.status, json_response["status"]
  end

  test "#find returns the null if status is not in database" do
    get :find, format: :json, status: "Not in there."
    assert_equal "null", response.body
  end

  test "#find all responds to json" do
    get :find_all, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test "#find all returns an array of records" do
    get :find_all, format: :json, first_name: Invoice.first.status
    assert_kind_of Array, json_response
  end

  test "#find all returns the correct invoices using status" do
    get :find_all, format: :json, status: Invoice.first.status
    assert_equal Invoice.first.status, json_response[0]["status"]
  end

  test "#find all returns the null if first name is not in database" do
    get :find_all, format: :json, status: "Not in there."
    assert_equal 0, json_response.count
  end

  test "#random responds to json" do
    get :random, format: :json
    assert_response :success
  end

  test "#random returns one record" do
    get :random, format: :json
    assert_kind_of Hash, json_response
  end

  test "#transactions returns correct records" do
    create_invoice_transactions

    get :transactions, format: :json, id: Invoice.first.id
    transaction = Invoice.first.transactions.first
    assert_equal transaction.credit_card_number, json_response.first["credit_card_number"]
    assert_equal transaction.created_at.to_json, json_response.first["created_at"].to_json
  end

  test "#invoice_items returns correct records" do
    create_invoice_items

    get :invoice_items, format: :json, id: Invoice.first.id
    invoice_item = Invoice.first.invoice_items.first
    assert_equal invoice_item.quantity, json_response.first["quantity"]
  end

  test "#items returns correct records" do
    create_invoice_items

    get :items, format: :json, id: Invoice.first.id
    item = Item.first
    assert_equal item.name, json_response.first["name"]
  end

  test "#customer returns correct records" do
    create_customer_invoices
    invoice = Customer.first.invoices.first

    get :customer, format: :json, id: invoice.id
    assert_equal Customer.first.first_name, json_response["first_name"]
  end

  test "#merchant returns correct records" do
    create_merchant_invoices
    invoice = Merchant.first.invoices.first

    get :merchant, format: :json, id: invoice.id
    assert_equal Merchant.first.name, json_response["name"]
  end
end
