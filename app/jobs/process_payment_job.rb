class ProcessPaymentJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Call payment gateway api here

    order = args[0]
    logger.debug "Payment for order #{order.id} total_cost: #{order.order_total}"
  end
end
