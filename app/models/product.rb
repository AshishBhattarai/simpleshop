class Product < ApplicationRecord
	has_many :product_orders
	has_many :orders, through: :product_orders

	validates :sku, presence: true, uniqueness: true
end
