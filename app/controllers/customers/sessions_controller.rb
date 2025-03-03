class Customers::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { 
        message: 'Logged in successfully.',
        customer: resource,
        token: request.env['warden-jwt_auth.token']
      }, status: :ok
    else
      render json: { message: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end