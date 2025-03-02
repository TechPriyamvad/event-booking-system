# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create an event organizer
event_organizer = EventOrganizer.create!(
  name: "Organizer 3",
  email: "organizer3@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# Create a customer
customer = Customer.create!(
  name: "Customer 3",
  email: "customer2@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# Create an event
event = Event.create!(
  title: "Sample Event",
  description: "This is a sample event.",
  date: DateTime.now + 7.days,
  venue: "Sample Venue",
  event_organizer: event_organizer
)

# Create tickets for the event
Ticket.create!(
  event: event,
  ticket_type: "General Admission",
  price: 50.00,
  availability: 100
)

Ticket.create!(
  event: event,
  ticket_type: "VIP",
  price: 100.00,
  availability: 50
)

# Create a booking
Booking.create!(
  customer: customer,
  ticket: event.tickets.first,
  event: event,
  quantity: 2
)

# Create a booking
Booking.create!(
  customer: customer,
  ticket: event.tickets.second,
  event: event,
  quantity: 2
)