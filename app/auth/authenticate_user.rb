class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    result = HashWithIndifferentAccess.new
    result[:user] = {email: user[:email], name: user[:name], user_id: user[:id]}
    result[:auth_token] = JsonWebToken.encode({user_id: user.id})
    result
  end

  private

  def user
    @user = User.find_by(email: @email)
    if @user && @user.authenticate(@password)
      return @user
    end
    raise(
      ExceptionHandler::AuthenticationError, "Invalid Credentials"
    )
  end
end