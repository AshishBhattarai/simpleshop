class OrdersController < ApplicationController
	include AuthConcern
	# Only customers can create an order
	before_action :raise_exception_if_not_customer, only: %i[create]

	attr_reader :orders

	# List all orders by the user
	def index
		@orders = Order.where(users_id: @user.id)
	end

	def show
		check_user_status -> { @order = Order.find_by!(id: params[:id]) },
											-> { @order = Order.find_by!(id: params[:id], users_id: @user.id) }
	end


	# For now this only supports single quantity per product pre order
	def create
		# validate params
		product_ids = params[:product_ids]&.uniq()
		if !product_ids&.present?
			raise ApiException.new("Product ids requred", 400)
		end
		order = Order.new(order_params)
		order.paid = false
		order.users_id = @user.id

		# check stock, save order and link
		ActiveRecord::Base.transaction do
			# Pessimistic lock, select for update
			products = Product.lock.where("id IN (?) AND stock > 0", product_ids)

			if product_ids.size != products.length
				raise ApiException.new("Invalid or out of stock product.", 400)
			end
			Product.update_counters(product_ids, :stock => -1)

			# total
			order_total = products.map{ |p| p.price }.reduce(:+)
			order.order_total = order_total
			order.save

			# Add entry to Product_Order
			product_orders = products.map { |p| {order_id: order.id, product_id: p.id, created_at: Time.now, updated_at: Time.now } }
			ProductOrder.insert_all(product_orders)
		end

		# Call payment gateway API
		ProcessPaymentJob.set(wait: 1.minutes).perform_later(order)
	end

	# Able to change customer_name and shipping_address
	# Only admins can update orders that they don't own
	def update
		check_user_status -> {
			@order = Order.find_by!(id: params[:id])
		}, -> {
			@order = Order.find_by!(id: params[:id], users_id: @user.id)
		}
		@order.update(order_params)
	end


	# Only admins can destroy orders that they don't own
	def destroy
		check_user_status -> {
			@order = Order.find_by!(id: params[:id])
		}, -> {
			@order = Order.find_by!(id: params[:id], users_id: @user.id)
		}
		@order.destroy
	end

	private
	def order_params
		params.require(:order).permit(:customer_name, :shipping_address)
	end

end
