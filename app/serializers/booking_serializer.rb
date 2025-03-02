# filepath: app/serializers/booking_serializer.rb
class BookingSerializer < ActiveModel::Serializer
    attributes :id, :customer_id, :event_id, :ticket_id, :quantity, :created_at, :updated_at
  end