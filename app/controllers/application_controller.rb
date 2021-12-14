class ApplicationController < ActionController::Base
	around_action :handle_exceptions #, if: proc { request.path.include?('/api') }
  skip_before_action :verify_authenticity_token

	# map all exception to proper http status code and json body
	def handle_exceptions
    begin
      yield
		rescue ApiException => e
			@status = e.error_code
    rescue ActiveRecord::RecordNotFound => e
      @status = 404
      @message = 'Record not found'
    rescue ActiveRecord::RecordInvalid => e
      render_unprocessable_entity_response(e.record) && return
    rescue ArgumentError => e
      @status = 400
    rescue StandardError => e
      @status = 500
    end
    render(json: { success: false, message: @message || e.message || "unknown error", code: @status }, status: @status) unless e.class == NilClass
  end
end
