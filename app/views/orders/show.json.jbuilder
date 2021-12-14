json.order do
	json.id @order.id
	json.customer_name @order.customer_name
	json.shipping_address @order.shipping_address
	json.order_total @order.order_total
	json.paid @order.paid
	json.paid_at @order.paid_at
end