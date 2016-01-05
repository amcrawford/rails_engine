class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def find
    respond_with Customer.find_by(customer_params)
  end

  def find_all
    respond_with Customer.where(customer_params).all
  end

  def random
    respond_with Customer.find(rand(1..Customer.count))
  end

  private

    def customer_params
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end
end
