# frozen_string_literal: true

# User authorization methods
module UserAuthorizationMethods
  extend ActiveSupport::Concern

  included { self._serialization_scope = nil }

  private

  def authenticate_user!
    current_user
  end

  def current_user
    @current_user ||= DecodeAuthenticationToken.new(token_from_header('X-ID-Token')).call
  end
end
