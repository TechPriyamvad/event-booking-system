# app/lib/custom_devise_failure_app.rb
class CustomDeviseFailureApp < Devise::FailureApp
    def respond
      if request.controller_class.to_s.start_with?('Api::') || request.format.json?
        json_failure
      else
        super
      end
    end
  
    def json_failure
      self.status = 401
      self.content_type = 'application/json'
      self.response_body = {
        status: { code: 401, message: i18n_message },
        errors: [i18n_message]
      }.to_json
    end
  end