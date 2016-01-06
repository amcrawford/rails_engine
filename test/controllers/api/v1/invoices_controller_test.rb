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

  test "#merchant items responds to json" do
    get :items, format: :json, id: Merchant.first.id
    assert_response :success
  end
end
