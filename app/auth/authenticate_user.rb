class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    {
      user: user
    }
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