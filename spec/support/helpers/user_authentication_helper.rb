# frozen_string_literal: true

module UserAuthenticationHelper
  extend ActiveSupport::Concern

  def token_auth_headers(user)
    { 'X-ID-Token' => id_token(user) }
  end

  def authenticate(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def id_token(user)
    encode({ email: user.email, nickname: user.nickname })
  end

  private

  def encode(payload)
    JWT.encode(payload.merge(expiration_stamp), Rails.application.credentials.hmac_secret, DecodeToken::ALGORITHM)
  end

  def expiration_stamp
    { iat: Time.now.to_i, exp: (Time.now + 10.seconds).to_i }
  end
end
