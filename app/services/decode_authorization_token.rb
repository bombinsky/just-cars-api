# frozen_string_literal: true

# Service responsible for decoding Authorization token.
# In case of wrong token one of following exceptions will be raised and handled by controller
# JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
# In future can be extended with appending eventual user permissions transmitted in Authorization token
class DecodeAuthorizationToken
  ALGORITHM = 'HS256'

  def initialize(token)
    @token = token
  end

  def call
    JWT.decode(token, Rails.application.credentials.hmac_secret, true, { algorithm: ALGORITHM }).first
  end

  private

  attr_reader :token
end
