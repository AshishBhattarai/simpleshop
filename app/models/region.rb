class Region < ApplicationRecord
	validates :currency, presence: true, uniqueness: true
	validates :title, presence: true
	validates :country, presence: true
	validates :tax, :numericality => { :greater_than_or_equal_to => 0 }
end
