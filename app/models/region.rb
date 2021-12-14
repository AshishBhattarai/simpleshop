class Region < ApplicationRecord
	validates :currency, presence: true, uniqueness: true
end
