class AuthorizeApiRequest
  def initialize(headers={})
    @headers = headers
  end

  def call
    result = authorize_request
  end

  private

  def authorize_request
    {
      user: user
    }
  end
  
  def user
    @user ||= User.find_by!(id: decoded_auth_token) if decoded_auth_token

    rescue ActiveRecord::RecordNotFound => e
      raise(
        ExceptionHandler::InvalidToken, "Invalid Token: #{e.message}"
      )
  end

  def decoded_auth_token
    auth_token ||= JsonWebToken.decode(authorization_header)['user_id']
  end

  def authorization_header
    if @headers['Authorization'].present?
      return @headers['Authorization'].split[0]
    end

    raise(ExceptionHandler::MissingToken, "Missing Token") 
  end
    

end