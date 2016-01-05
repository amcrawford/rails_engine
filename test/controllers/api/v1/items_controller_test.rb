require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
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
    assert_equal Item.count, json_response.count
  end

  test "#index contains items that have the correct properties" do
    get :index, format: :json

    json_response.each do |item|
      assert item["name"]
      assert item["description"]
      assert item["unit_price"]
    end
  end

  test "#show response to json" do
    get :show, format: :json, id: Item.first.id
    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Item.first.id
    assert_kind_of Hash, json_response
  end

  test "#show returns the correct customer" do
    get :show, format: :json, id: Item.first.id
    assert_equal Item.first.id, json_response["id"]
  end

  test "#find responds to json" do
    get :find, format: :json, id: Item.first.id
    assert_response :success
  end

  test "#find returns one record" do
    get :find, format: :json, id: Item.first.id
    assert_kind_of Hash, json_response
  end

  test "#find returns the correct item" do
    get :find, format: :json, id: Item.first.id
    assert_equal Item.first.id, json_response["id"]
  end

  test "#find returns the correct item using name" do
    get :find, format: :json, name: Item.first.name
    assert_equal Item.first.name, json_response["name"]
  end

  test "#find returns the correct item using description" do
    get :find, format: :json, description: Item.first.description
    assert_equal Item.first.description, json_response["description"]
  end

  test "#find returns the null if name is not in database" do
    get :find, format: :json, name: "Not in there."
    assert_equal "null", response.body
  end

  test "#find all responds to json" do
    get :find_all, format: :json, id: Item.first.id
    assert_response :success
  end

  test "#find all returns an array of records" do
    get :find_all, format: :json, name: Item.first.name
    assert_kind_of Array, json_response
  end

  test "#find all returns the correct customers using description" do
    get :find_all, format: :json, description: Item.first.description
    assert_equal Item.first.description, json_response[0]["description"]
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
