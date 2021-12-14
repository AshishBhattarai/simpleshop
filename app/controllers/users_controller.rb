require 'jwt'

class UsersController < ApplicationController
	include AuthConcern

	skip_before_action :verify_token, only: %i[login] # Skip JWT verifcation for login
	before_action :validate_params_login, only: %i[login]

	attr_reader :login

	# login logic
	def login
		user = User.find_by(username: params[:username])
		# authenticate
		if user.present? && user.authenticate(params[:password])
			# generate jwt token
			payload = { username: user.username }
			secret = Rails.application.secrets['jwt_secret_key_base']
			token = JWT.encode(payload, secret, 'HS512')
			@login = { user: user, token: token }
		else
			raise ApiException.new('Invalid password or username', 401)
		end
	end

	# return current user
	def me
		@user
	end

	private
	def validate_params_login
		if params[:username].blank? || params[:password].blank?
			raise ApiException.new('Username or password empty', 400)
		end
	end

end
