# frozen_string_literal: true

# Service responsible for tokens decoding
class DecodeToken
  ALGORITHM = 'HS256'

  def initialize(id_token)
    @id_token = HashWithIndifferentAccess.new(decoded(id_token))
  end

  def call
    User.find_by(email: email) || User.create!(email: email, nickname: nickname)
  end

  private

  attr_reader :id_token

  def email
    id_token[:email]
  end

  def nickname
    id_token[:nickname]
  end

  def decoded(token)
    JWT.decode(token, Rails.application.credentials.hmac_secret, true, { algorithm: ALGORITHM }).first
  end
end
