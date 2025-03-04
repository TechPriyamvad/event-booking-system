class ApplicationController < ActionController::API
    # before_action :authenticate_customer!
    # include ActionController::Cookies
    # include ActionController::MimeResponds
    include ActionController::MimeResponds
    respond_to :json

    # role based api access helper methods
    
    def current_user
        current_customer || current_event_organizer
    end
    
    def user_signed_in?
        customer_signed_in? || event_organizer_signed_in?
    end
    
    def authorize_customer!
        unless customer_signed_in?
        render json: { 
            success: false, 
            message: "You need to be signed in as a customer to perform this action.",
            error: "unauthorized_role" 
        }, status: :forbidden
        end
    end
    
    def authorize_event_organizer!
        unless event_organizer_signed_in?
        render json: { 
            success: false, 
            message: "You need to be signed in as an event organizer to perform this action.",
            error: "unauthorized_role" 
        }, status: :forbidden
        end
    end
    private
  
    def jwt_revoked
        render json: {
        success: false,
        message: "Your session has expired. Please sign in again.",
        error: "token_revoked"
        }, status: :unauthorized
    end
    
    def jwt_not_found
        render json: {
        success: false,
        message: "Authentication token not found. Please sign in.",
        error: "token_not_found" 
        }, status: :unauthorized
    end
    
    def jwt_decode_error
        render json: {
        success: false,
        message: "Authentication token is invalid. Please sign in again.",
        error: "invalid_token"
        }, status: :unauthorized
    end
end
