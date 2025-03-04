# filepath: app/controllers/events_controller.rb
class EventsController < ApplicationController
    before_action :authenticate_event_organizer!, except: [:index, :show]
    # Add this to check role for write operations
    before_action :authorize_event_organizer!, except: [:index, :show]
    before_action :set_event, only: [:show, :update, :destroy]
    # Also add owner verification for updates and deletes
    before_action :verify_event_owner!, only: [:update, :destroy]

    # GET /events
    def index
      @events = Event.all
      render json: @events
    end
  
    # GET /events/:id
    def show
      render json: @event
    end
  
    # POST /events
    def create
      @event = current_event_organizer.events.new(event_params)
      if @event.save
        render json: @event, status: :created, location: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /events/:id
    def update
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /events/:id
    def destroy
      @event.destroy
    end
  
    private

    # Add this method to verify event ownership
    def verify_event_owner!
      unless @event.event_organizer == current_event_organizer
        render json: { 
          success: false, 
          message: "You can only modify events that you created.",
          error: "unauthorized_action" 
        }, status: :forbidden
      end
    end
    def set_event
      @event = Event.find(params[:id])
    end
  
    def event_params
      params.require(:event).permit(:title, :description, :date, :venue, :event_organizer_id)
    end
end