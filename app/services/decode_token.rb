# frozen_string_literal: true

# Service responsible for tokens decoding
class DecodeToken
  ALGORITHM = 'RS256'

  def initialize(id_token)
    @id_token = decoded(id_token)
  end

  def call
    User.find_by(email: id_token[:email]) || User.create!(email: id_token[:email], nickname: id_token[:nickname])
  end

  private

  attr_reader :id_token

  def decoded(token)
    HashWithIndifferentAccess.new(JWT.decode(token, public_key, true, algorithm: ALGORITHM).first)
  end

  def public_key
    OpenSSL::PKey::RSA.new(ENV['JWT_PUBLIC_KEY'])
  end
end
