require 'rails_helper'

RSpec.describe "Order Routes", type: :request do

  before do
    @products = Product.where('stock > 0')
  end

  def call_orders(product_ids, token)
    post "/orders", params: { order: {customer_name: "cus_name", shipping_address: "kalanki, Kathmandu"}, product_ids: product_ids}, headers: { Authorization: "Bearer #{token}" }
  end

  def create_orders(token)
    product_ids = @products.map { |p| p.id }
    call_orders(product_ids, token)
  end

  describe "POST /orders" do
    it "create order with customer" do
      token = login_customer
      product = @products.first

      call_orders([product.id], token)
      expect(response.status).to eq(204)

      # check stock count
      up_product = Product.find_by(id: product.id)
      expect(up_product.stock + 1).to eq(product.stock)
    end

    it "create order with admin" do
      token = login_admin
      product = @products.first

      call_orders([product.id], token)
      expect(response.status).to eq(403)

      # check stock count
      up_product = Product.find_by(id: product.id)
      expect(up_product.stock).to eq(product.stock)
    end

    it "create order with customer_admin" do
      # user with both customer and admin privilege
      token = login_admin_customer
      product = @products.first

      call_orders([product.id], token)
      expect(response.status).to eq(204)

      # check stock count
      up_product = Product.find_by(id: product.id)
      expect(up_product.stock + 1).to eq(product.stock)
    end

    it "create order for out of stuck product" do
      # user with both customer and admin privilege
      token = login_admin_customer
      product = @products.first
      product.stock = 0
      product.save

      post "/orders", params: { order: {customer_name: "cus_name", shipping_address: "kalanki, Kathmandu"}, product_ids: [product.id]}, headers: { Authorization: "Bearer #{token}" }
      expect(response.status).to eq(400)
    end
  end

  describe "GET /orders" do
    it "fetch orders" do
      # can be place inde before for GET /orders
      token = login_admin_customer
      create_orders(token)

      get "/orders", headers: { Authorization: "Bearer #{token}", Accept: "application/json" }
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /orders/:id" do
    before do
      @token = login_admin_customer
      create_orders(@token)
    end

    it "fetch order" do
      get "/orders/#{Order.first.id}", headers: { Authorization: "Bearer #{@token}", Accept: "application/json" }
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end

    it "fetch non owning order with customer" do
      @token = login_customer

      get "/orders/#{Order.first.id}", headers: { Authorization: "Bearer #{@token}", Accept: "application/json" }
      expect(response.status).to eq(404)
    end

    it "fetch non owning order with admin" do
      @token = login_admin

      get "/orders/#{Order.first.id}", headers: { Authorization: "Bearer #{@token}", Accept: "application/json" }
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end

  describe "PUT /orders/:id" do
   before do
      @token = login_admin_customer
      create_orders(@token)
    end

    it "update orders" do
      order = Order.first

      put "/orders/#{order.id}", params: { order: {customer_name: "UP_NAME", shipping_address: "UP_SHIP"}}, headers: { Authorization: "Bearer #{@token}" }
      up_order = Order.find_by(id: order.id)
      expect(response.status).to eq(204)
      expect(up_order.customer_name).to eq("UP_NAME")
      expect(up_order.shipping_address).to eq("UP_SHIP")
    end

    it "update non owning order with customer" do
      @token = login_customer
      order = Order.first

      put "/orders/#{order.id}", params: { order: {customer_name: "UP_NAME", shipping_address: "UP_SHIP"}}, headers: { Authorization: "Bearer #{@token}" }
      up_order = Order.find_by(id: order.id)
      expect(response.status).to eq(404)
      expect(up_order.customer_name).to eq(order.customer_name)
      expect(up_order.shipping_address).to eq(order.shipping_address)
    end

    it "update non owning order with admin" do
      @token = login_admin
      order = Order.first

      put "/orders/#{order.id}", params: { order: {customer_name: "UP_NAME", shipping_address: "UP_SHIP"}}, headers: { Authorization: "Bearer #{@token}" }
      up_order = Order.find_by(id: order.id)
      expect(response.status).to eq(204)
      expect(up_order.customer_name).to eq("UP_NAME")
      expect(up_order.shipping_address).to eq("UP_SHIP")
    end
  end
end
