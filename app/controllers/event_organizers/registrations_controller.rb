class EventOrganizers::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    
    def create
      build_resource(sign_up_params)
      resource.save
      
      if resource.persisted?
        if resource.active_for_authentication?
          # The same approach you used for customers - avoid session dependency
          render json: {
            status: { code: 200, message: 'Event organizer signed up successfully.' },
            data: resource
          }
        else
          # Handle inactive account
          render json: {
            status: { code: 401, message: 'Account not active' },
            data: resource
          }, status: :unauthorized
        end
      else
        render json: {
          status: { code: 422, message: resource.errors.full_messages.join(', ') },
          data: resource.errors
        }, status: :unprocessable_entity
      end
    end
  
    private
  
    def sign_up_params
      params.require(:event_organizer).permit(:email, :password, :password_confirmation, :name)
    end
  end