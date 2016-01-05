require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of merchants" do
    get :index, format: :json
    assert_equal Merchant.count, json_response.count
  end

  test "#index contains items that have the correct properties" do
    get :index, format: :json

    json_response.each do |merchant|
      assert merchant["name"]
      assert merchant["created_at"]
    end
  end

  test "#show response to json" do
    get :show, format: :json, id: Merchant.first.id
    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Merchant.first.id
    assert_kind_of Hash, json_response
  end

  test "#show returns the correct merchant" do
    get :show, format: :json, id: Merchant.first.id
    assert_equal Merchant.first.id, json_response["id"]
  end

  test "#find responds to json" do
    get :find, format: :json, id: Merchant.first.id
    assert_response :success
  end

  test "#find returns one record" do
    get :find, format: :json, id: Merchant.first.id
    assert_kind_of Hash, json_response
  end

  test "#find returns the correct merchant" do
    get :find, format: :json, id: Merchant.first.id
    assert_equal Merchant.first.id, json_response["id"]
  end

  test "#find returns the correct item using name" do
    get :find, format: :json, name: Merchant.first.name
    assert_equal Merchant.first.name, json_response["name"]
  end

  test "#find returns the correct item using created_at" do
    get :find, format: :json, created_at: Merchant.first.created_at
    assert_equal Merchant.first.created_at, json_response["created_at"]
  end

  test "#find returns the null if name is not in database" do
    get :find, format: :json, name: "Not in there."
    assert_equal "null", response.body
  end

  test "#find all responds to json" do
    get :find_all, format: :json, id: Merchant.first.id
    assert_response :success
  end

  test "#find all returns an array of records" do
    get :find_all, format: :json, name: Merchant.first.name
    assert_kind_of Array, json_response
  end

  test "#find all returns the correct merchants using name" do
    get :find_all, format: :json, name: Merchant.first.name
    assert_equal Merchant.first.name, json_response[0]["name"]
  end

  test "#find all returns the null if name is not in database" do
    get :find_all, format: :json, name: "Not in there."
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
