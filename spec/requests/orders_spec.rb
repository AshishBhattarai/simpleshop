require 'rails_helper'

RSpec.describe "Order Routes", type: :request do

  before do
    @products = Product.where('stock > 0')
  end

  describe "POST /orders" do
    it "create order with customer" do
      token = login_customer
      product = @products.first

      post "/orders", params: { order: {customer_name: "cus_name", shipping_address: "kalanki, Kathmandu"}, product_ids: [product.id]}, headers: { Authorization: "Bearer #{token}" }
      expect(response.status).to eq(204)

      # check stock count
      up_product = Product.find_by(id: product.id)
      expect(up_product.stock + 1).to eq(product.stock)
    end
  end
end
