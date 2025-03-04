class EventUpdateNotificationWorker
    include Sidekiq::Worker
    sidekiq_options queue: :default, retry: 3
  
    def perform(event_id, changes)
      event = Event.find_by(id: event_id)
      return unless event
      
      # Find all bookings for this event
      bookings = event.bookings
      
      # Notify each customer who has a booking
      bookings.each do |booking|
        EventMailer.event_updated_notification(booking.id, changes).deliver_now
      end
    end
  end