# frozen_string_literal: true

module AuhorizationAndAuthenticationHelper
  extend ActiveSupport::Concern

  def authorization_header
    { 'Authorization' => JWT.encode(expiration_stamp, hmac_secret, DecodeAuthorizationToken::ALGORITHM) }
  end

  def authentication_header(user)
    { 'X-ID-Token' => authentication_token(user) }
  end

  def authenticate(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def authorize_request
    allow(controller).to receive(:authorize!)
  end

  def authorization_token
    encode({})
  end

  def authentication_token(user)
    encode({ email: user.email, nickname: user.nickname })
  end

  private

  def encode(payload)
    JWT.encode(payload.merge(expiration_stamp), hmac_secret, DecodeAuthenticationToken::ALGORITHM)
  end

  def expiration_stamp
    { iat: Time.now.to_i, exp: (Time.now + 10.seconds).to_i }
  end

  def hmac_secret
    Rails.application.credentials.hmac_secret
  end
end
