# frozen_string_literal: true

# Service responsible for tokens decoding
class DecodeToken
  ALGORITHM = 'HS256'

  def initialize(id_token)
    @id_token = HashWithIndifferentAccess.new(decoded(id_token))
  end

  def call
    User.find_by(email: id_token[:email]) || User.create!(email: id_token[:email], nickname: id_token[:nickname])
  end

  private

  attr_reader :id_token

  def decoded(token)
    JWT.decode(token, Rails.application.credentials.hmac_secret, true, { algorithm: ALGORITHM }).first
  end
end
