class Customers::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    
    def create
      build_resource(sign_up_params)
      resource.save
      
      if resource.persisted?
        if resource.active_for_authentication?
          # Don't call sign_up which tries to use sessions
          # sign_up(resource_name, resource)
          
        #   # Generate JWT token manually using warden-jwt_auth
        #   payload = { 
        #     sub: resource.id,
        #     scp: 'customer',
        #     aud: nil, 
        #     iat: Time.now.to_i,
        #     exp: 1.day.from_now.to_i,
        #     jti: SecureRandom.uuid
        #   }
          
        #   token = JWT.encode(
        #     payload, 
        #     Rails.application.credentials.devise_jwt_secret_key, 
        #     'HS256'
        #   )
          
          render json: {
            status: { code: 200, message: 'Signed up successfully.' },
            data: resource,
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
      params.require(:customer).permit(:email, :password, :password_confirmation, :name)
    end
  end