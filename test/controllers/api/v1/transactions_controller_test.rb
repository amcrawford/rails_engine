require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of transactions" do
    get :index, format: :json
    assert_equal Transaction.count, json_response.count
  end

  test "#index contains transaction that have the correct properties" do
    get :index, format: :json

    json_response.each do |transaction|
      assert transaction["credit_card_number"]
      assert transaction["result"]
    end
  end

  test "#show response to json" do
    get :show, format: :json, id: Transaction.first.id
    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Transaction.first.id
    assert_kind_of Hash, json_response
  end

  test "#show returns the correct transaction" do
    get :show, format: :json, id: Transaction.first.id
    assert_equal Transaction.first.id, json_response["id"]
  end

  test "#find responds to json" do
    get :find, format: :json, id: Transaction.first.id
    assert_response :success
  end

  test "#find returns one record" do
    get :find, format: :json, id: Transaction.first.id
    assert_kind_of Hash, json_response
  end

  test "#find returns the correct transaction" do
    get :find, format: :json, id: Transaction.first.id
    assert_equal Transaction.first.id, json_response["id"]
  end

  test "#find returns the correct transaction using name" do
    get :find, format: :json, result: Transaction.first.result
    assert_equal Transaction.first.result, json_response["result"]
  end

  test "#find returns the correct transaction using updated_at" do
    get :find, format: :json, updated_at: Transaction.first.updated_at
    assert_equal Transaction.first.updated_at, json_response["updated_at"]
  end

  test "#find returns the null if result is not in database" do
    get :find, format: :json, result: "Not in there."
    assert_equal "null", response.body
  end

  test "#find all responds to json" do
    get :find_all, format: :json, id: Transaction.first.id
    assert_response :success
  end

  test "#find all returns an array of records" do
    get :find_all, format: :json, result: Transaction.first.result
    assert_kind_of Array, json_response
  end

  test "#find all returns the correct transaction using credit_card_number" do
    get :find_all, format: :json, credit_card_number: Transaction.first.credit_card_number
    assert_equal Transaction.first.credit_card_number, json_response[0]["credit_card_number"]
  end

  test "#find all returns the null if result is not in database" do
    get :find_all, format: :json, result: "Not in there."
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
end
