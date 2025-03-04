class EventMailer < ApplicationMailer
    default from: 'notifications@eventbooking.com'
  
    def event_updated_notification(booking_id, changes)
      @booking = Booking.find(booking_id)
      @customer = @booking.customer
      @event = @booking.event
      @ticket = @booking.ticket
      @changes = changes
      
      mail(
        to: @customer.email,
        subject: "Update for Event: #{@event.title}"
      )
      
      # Keep this for debugging if you want
        Rails.logger.info "======================================"
        Rails.logger.info "SENDING BOOKING CONFIRMATION EMAIL TO: #{@customer.email}"
        Rails.logger.info "EVENT: #{@event.title}"
        Rails.logger.info "TICKET TYPE: #{@ticket.ticket_type}"
        Rails.logger.info "QUANTITY: #{@booking.quantity}"
        Rails.logger.info "TOTAL PRICE: $#{@ticket.price * @booking.quantity}"
    end
end