class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secret_key_base

  def self.encode(payload, exp = 1.month.from_now)

    # set expiry to 1 month from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # Extract the payload
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
    
    # rescue from decode errors
    rescue JWT::DecodeError => e
      # raise custom error to be handled by custom handler
      raise ExceptionHandler::InvalidToken, e.message
  end
end