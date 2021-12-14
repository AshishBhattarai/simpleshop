class User < ApplicationRecord
	has_secure_password

	validates :username, presence: true, uniqueness: true
	validates :password_digest, presence: true

	def is_admin?
		user_type != 2
	end

	def is_customer?
		user_type != 1
	end

	def is_admin_customer?
		user_type == 3
	end
end
