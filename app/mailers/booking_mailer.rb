class BookingMailer < ApplicationMailer
    default from: 'notifications@eventbooking.com'
  
    def booking_confirmation(booking_id)
      @booking = Booking.find(booking_id)
      @customer = @booking.customer
      @event = @booking.event
      @ticket = @booking.ticket
      
      mail(
        to: @customer.email,
        subject: "Booking Confirmation for #{@event.title}"
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