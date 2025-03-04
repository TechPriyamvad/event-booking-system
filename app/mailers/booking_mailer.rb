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
      
      # For assignment purposes, print to console instead of sending
      puts "======================================"
      puts "SENDING BOOKING CONFIRMATION EMAIL TO: #{@customer.email}"
      puts "EVENT: #{@event.title}"
      puts "TICKET TYPE: #{@ticket.ticket_type}"
      puts "QUANTITY: #{@booking.quantity}"
      puts "TOTAL PRICE: $#{@ticket.price * @booking.quantity}"
      puts "======================================"
    end
  end