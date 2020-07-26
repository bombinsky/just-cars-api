# frozen_string_literal: true

# User authorization methods
module UserAuthorizationMethods
  extend ActiveSupport::Concern

  included { self._serialization_scope = nil }

  private

  delegate :headers, to: :request

  def authenticate_user!
    current_user
  end

  def current_user
    @current_user ||= DecodeToken.new(token_from_header('X-ID-Token')).call
  end

  def token_from_header(header_name)
    headers[header_name].split(' ').last if headers[header_name].present?
  end
end
