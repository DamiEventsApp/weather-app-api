class AuthenticationController < ApplicationController
  def login
    authenticated_user = AuthenticateUser.new(
      params[:email], params[:password]
    ).call
    json_response(authenticated_user)
  end
end