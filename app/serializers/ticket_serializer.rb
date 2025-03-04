class TicketSerializer < ActiveModel::Serializer
    attributes :id, :ticket_type, :price, :availability, :created_at, :updated_at
    belongs_to :event
end