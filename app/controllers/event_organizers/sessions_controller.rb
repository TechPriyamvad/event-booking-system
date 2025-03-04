class EventOrganizers::SessionsController < Devise::SessionsController
    respond_to :json
  
    def create
      self.resource = warden.authenticate!(auth_options)
      token = request.env['warden-jwt_auth.token']
      
      render json: {
        status: { code: 200, message: 'Event organizer signed in successfully.' },
        data: resource,
        token: token
      }
    end
  
    private
  
    def respond_to_on_destroy
      head :no_content
    end
  end