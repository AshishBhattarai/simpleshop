class ApiException < StandardError

attr_reader :error_code

	def initialize(msg, error_code)
		super(msg)
		@error_code = error_code
	end
end