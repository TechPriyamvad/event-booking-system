# filepath: app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
    before_action :authenticate_customer!
    before_action :authorize_customer!
    before_action :set_event
    before_action :set_booking, only: [:show, :destroy]
  
    # GET /events/:event_id/bookings
    def index
      @bookings = @event.bookings
      render json: @bookings
    end
  
    # GET /events/:event_id/bookings/:id
    def show
      render json: @booking
    end
  
    # POST /events/:event_id/bookings
    def create
      @booking = current_customer.bookings.build(booking_params)
      @booking.event = @event  # This line is crucial
  
      if @booking.save
        render json: @booking, status: :created, location: [@event, @booking]
      else
        Rails.logger.info @booking.errors.full_messages
        render json: @booking.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /events/:event_id/bookings/:id
    def destroy
      @booking.destroy
    end
  
    private
  
    def set_event
      @event = Event.find(params[:event_id])
    end
  
    def set_booking
      @booking = @event.bookings.find(params[:id])
    end
  
    def booking_params
      params.require(:booking).permit(:ticket_id, :quantity)
    end
  end