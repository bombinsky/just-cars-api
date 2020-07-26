class ApplicationController < ActionController::API
  include ExceptionsHandling

  before_action :authorize!

  protected

  delegate :headers, to: :request

  def authorize!
    DecodeAuthorizationToken.new(token_from_header('Authorization')).call
  end

  def token_from_header(header_name)
    headers[header_name].split(' ').last if headers[header_name].present?
  end
end
