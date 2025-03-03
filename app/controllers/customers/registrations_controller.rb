class Customers::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    
    def create
      build_resource(sign_up_params)
      
      resource.save
      
      if resource.persisted?
        # Generate JWT token directly without using sessions
        token = nil
        if resource.active_for_authentication?
          # Generate the JWT token manually, avoiding Devise's session-based process
          payload = { sub: resource.id, scp: 'customer' }
          token = JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key, 'HS256')
        end
        
        render json: {
          status: { code: 200, message: 'Signed up successfully.' },
          data: resource,
          token: token
        }
      else
        render json: {
          status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
        }, status: :unprocessable_entity
        clean_up_passwords resource
        set_minimum_password_length
      end
    end
  
    private
  
    def sign_up_params
      params.require(:customer).permit(:email, :password, :password_confirmation, :name)
    end
  end