class Order < ApplicationRecord
	has_many :product_orders, :dependent => :destroy
	has_many :products, through: :product_orders

	validates :customer_name, presence: true
	validates :shipping_address, presence: true
end
