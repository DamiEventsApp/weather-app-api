class AuthenticationController < ApplicationController
  skip_before_action :authorize_api_request, only: %i[ login ]

  def login
    authenticated_user = AuthenticateUser.new(
      params[:email], params[:password]
    ).call
    json_response(authenticated_user)
  end
end