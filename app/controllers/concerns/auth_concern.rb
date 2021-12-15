module AuthConcern
	extend ActiveSupport::Concern

	included do
		attr_reader :user
		before_action :verify_token
	end

	# verify token and set user
	def verify_token
		token = request.headers['Authorization']&.split(" ")&.last
		if !token.blank?
			secret = Rails.application.secrets['jwt_secret_key_base']
			begin
				payload = JWT.decode(token, secret, true, { algorithm:'HS512' }).first
				@user = User.find_by(username: payload["username"])
			rescue JWT::DecodeError
				raise ApiException.new('Invalid token', 401)
			end
		else
			raise ApiException.new('Invalid token', 401)
		end
	end

	def check_user_status(with_admin, with_customer)
		if @user.is_admin?
			with_admin.()
		else
			with_customer.()
		end
	end

	def raise_exception_if_not_customer(msg = "Only customers are allowed to access this resource.")
		if !@user.is_customer?
			raise ApiException.new(msg, 403)
		end
	end

end