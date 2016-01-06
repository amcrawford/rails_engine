require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
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
    assert_equal Customer.count, json_response.count
  end

  test "#index contains customers that have the correct properties" do
    get :index, format: :json

    json_response.each do |customer|
      assert customer["first_name"]
      assert customer["last_name"]
    end
  end

  test "#show response to json" do
    get :show, format: :json, id: Customer.first.id
    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Customer.first.id
    assert_kind_of Hash, json_response
  end

  test "#show returns the correct customer" do
    get :show, format: :json, id: Customer.first.id
    assert_equal Customer.first.id, json_response["id"]
  end

  test "#find responds to json" do
    get :find, format: :json, id: Customer.first.id
    assert_response :success
  end

  test "#find returns one record" do
    get :find, format: :json, id: Customer.first.id
    assert_kind_of Hash, json_response
  end

  test "#find returns the correct customer" do
    get :find, format: :json, id: Customer.first.id
    assert_equal Customer.first.id, json_response["id"]
  end

  test "#find returns the correct customer using first name" do
    get :find, format: :json, first_name: Customer.first.first_name
    assert_equal Customer.first.first_name, json_response["first_name"]
  end

  test "#find returns the correct customer using last name" do
    get :find, format: :json, last_name: Customer.first.last_name
    assert_equal Customer.first.last_name, json_response["last_name"]
  end

  test "#find returns the null if first name is not in database" do
    get :find, format: :json, first_name: "Not in there."
    assert_equal "null", response.body
  end

  test "#find all responds to json" do
    get :find_all, format: :json, id: Customer.first.id
    assert_response :success
  end

  test "#find all returns an array of records" do
    get :find_all, format: :json, first_name: Customer.first.first_name
    assert_kind_of Array, json_response
  end

  test "#find all returns the correct customers using last name" do
    get :find_all, format: :json, last_name: Customer.first.last_name
    assert_equal Customer.first.last_name, json_response[0]["last_name"]
  end

  test "#find all returns the null if first name is not in database" do
    get :find_all, format: :json, first_name: "Not in there."
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

  test "#invoices returns correct records" do
    create_customer_invoices

    get :invoices, format: :json, id: Customer.first.id
    invoice = Customer.first.invoices.first
    assert_equal invoice.status, json_response.first["status"]
    assert_equal invoice.created_at.to_json, json_response.first["created_at"].to_json
  end

  test "#transactions returns correct records" do
    create_customer_invoices
    create_customer_transactions

    get :transactions, format: :json, id: Customer.first.id
    transaction = Customer.first.invoices.first.transactions.first
    assert_equal transaction.credit_card_number, json_response.first["credit_card_number"]
    assert_equal transaction.created_at.to_json, json_response.first["created_at"].to_json
  end

  test "#favorite merchants returns correct records" do
    create_customer_invoices
    create_customer_transactions

    get :favorite_merchant, format: :json, id: Customer.first.id
    merchant = Customer.first.invoices.first.merchant
    assert_equal merchant.name, json_response["name"]
  end
end
