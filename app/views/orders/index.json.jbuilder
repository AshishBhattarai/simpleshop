json.orders do
	json.array! @orders, :id, :customer_name, :shipping_address, :order_total, :paid, :paid_at
end