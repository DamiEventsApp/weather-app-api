class ApplicationController < ActionController::API
  before_action :authorize_api_request
  attr_reader :current_user
  
  include Response
  include ExceptionHandler

  private

  def authorize_api_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end
end
