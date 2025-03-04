class BookingConfirmationWorker
    include Sidekiq::Worker
    sidekiq_options retry: 3
  
    def perform(booking_id)
      # Find the booking
      booking = Booking.find_by(id: booking_id)
      return unless booking
  
      # Send the email
      BookingMailer.booking_confirmation(booking_id).deliver_now
    end
  end