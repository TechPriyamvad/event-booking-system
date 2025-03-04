class TicketsController < ApplicationController
    before_action :authenticate_event_organizer!, except: [:index, :show]
    before_action :authorize_event_organizer!, except: [:index, :show]
    before_action :set_event
    before_action :set_ticket, only: [:show, :update, :destroy]
    before_action :verify_event_owner!, except: [:index, :show]
  
    # GET /events/:event_id/tickets
    def index
      @tickets = @event.tickets
      render json: @tickets
    end
  
    # GET /events/:event_id/tickets/:id
    def show
      render json: @ticket
    end
  
    # POST /events/:event_id/tickets
    def create
      @ticket = @event.tickets.build(ticket_params)
  
      if @ticket.save
        render json: @ticket, status: :created, location: [@event, @ticket]
      else
        render json: @ticket.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /events/:event_id/tickets/:id
    def update
      if @ticket.update(ticket_params)
        render json: @ticket
      else
        render json: @ticket.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /events/:event_id/tickets/:id
    def destroy
      @ticket.destroy
      render json: { message: "Ticket successfully deleted" }, status: :ok
    end
  
    private
  
    def set_event
      @event = Event.find(params[:event_id])
    end
  
    def set_ticket
      @ticket = @event.tickets.find(params[:id])
    end
  
    def ticket_params
      params.require(:ticket).permit(:ticket_type, :price, :availability)
    end
  
    def verify_event_owner!
      unless @event.event_organizer == current_event_organizer
        render json: { 
          success: false, 
          message: "You can only modify tickets for events that you created.",
          error: "unauthorized_action" 
        }, status: :forbidden
      end
    end
  end