class ApplicationController < ActionController::API
    before_action :authenticate_customer!
end
