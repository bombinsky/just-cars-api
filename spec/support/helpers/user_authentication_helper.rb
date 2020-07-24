# frozen_string_literal: true

module UserAuthenticationHelper
  extend ActiveSupport::Concern

  included do
    before do
      stub_const('ENV', 'JWT_PUBLIC_KEY' => rsa_public_key)
    end
  end

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

  def rsa_private
    @rsa_private ||= OpenSSL::PKey::RSA.generate 2048
  end

  def rsa_public
    @rsa_public ||= rsa_private.public_key
  end

  def rsa_public_key
    @rsa_public_key ||= rsa_public.to_s
  end

  def encode(payload)
    JWT.encode payload.merge(shared), rsa_private, DecodeToken::ALGORITHM
  end

  def shared
    { iat: Time.now.to_i, exp: (Time.now + 10.seconds).to_i }
  end
end
