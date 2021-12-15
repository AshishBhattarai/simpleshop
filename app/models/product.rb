class Product < ApplicationRecord
	has_many :product_orders
	has_many :orders, through: :product_orders

	validates :sku, presence: true, uniqueness: true
	validates :title, presence: true
	validates :description, presence: true
	validates :image_url, presence: true
	validates :stock, :numericality => { :greater_than_or_equal_to => 0 }
end
