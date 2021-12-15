module RequestHelpers

	def login(username, password)
		post "/users/login", params: { username: username, password: password }, headers: { Accept: "application/json" }
    token = ActiveSupport::JSON.decode(response.body)["jwt"]["token"]
		if token.blank?
			raise "Loing failed: #{response.body}"
		end
		token
	end

# password from db/seeds.rb, db/seeds.rb is ran before tests
	def login_admin
		login("test1", "pass_test1")
	end

	def login_customer
		login("test2", "pass_test2")
	end

	def login_admin_customer
		login("test3", "pass_test3")
	end
end