require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
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
    assert_equal InvoiceItem.count, json_response.count
  end

  test "#index contains customers that have the correct properties" do
    get :index, format: :json

    json_response.each do |invoice_item|
      assert invoice_item["quantity"]
      assert invoice_item["unit_price"]
    end
  end

  test "#show response to json" do
    get :show, format: :json, id: InvoiceItem.first.id
    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: InvoiceItem.first.id
    assert_kind_of Hash, json_response
  end

  test "#show returns the correct invoice item" do
    get :show, format: :json, id: InvoiceItem.first.id
    assert_equal InvoiceItem.first.id, json_response["id"]
  end

  test "#find responds to json" do
    get :find, format: :json, id: InvoiceItem.first.id
    assert_response :success
  end

  test "#find returns one record" do
    get :find, format: :json, id: InvoiceItem.first.id
    assert_kind_of Hash, json_response
  end

  test "#find returns the correct invoice item" do
    get :find, format: :json, id: InvoiceItem.first.id
    assert_equal InvoiceItem.first.id, json_response["id"]
  end

  test "#find returns the correct invoice item using quantity" do
    get :find, format: :json, quantity: InvoiceItem.first.quantity
    assert_equal InvoiceItem.first.quantity, json_response["quantity"]
  end

  test "#find returns the null if invoice_id is not in database" do
    get :find, format: :json, invoice_id: "#{Invoice.last.id + 1}"
    assert_equal "null", response.body
  end

  test "#find all responds to json" do
    get :find_all, format: :json, id: InvoiceItem.first.id
    assert_response :success
  end

  test "#find all returns an array of records" do
    get :find_all, format: :json, quantity: InvoiceItem.first.quantity
    assert_kind_of Array, json_response
  end

  test "#find all returns the correct customers using quantity" do
    get :find_all, format: :json, quantity: InvoiceItem.first.quantity
    assert_equal InvoiceItem.first.quantity, json_response[0]["quantity"]
  end

  test "#find all returns the null if invoice_id is not in database" do
    get :find_all, format: :json, invoice_id: "#{Invoice.last.id + 1}"
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

  test "#invoice returns correct records" do
    invoice_item = InvoiceItem.first
    invoice_item.update(invoice_id: Invoice.first.id)

    get :invoice, format: :json, id: InvoiceItem.first.id
    assert_equal invoice_item.invoice.id, json_response["id"]
  end

  test "#item returns correct records" do
    invoice_item = InvoiceItem.first
    invoice_item.update(item_id: Item.first.id)

    get :item, format: :json, id: InvoiceItem.first.id
    assert_equal invoice_item.item.id, json_response["id"]
  end
end
