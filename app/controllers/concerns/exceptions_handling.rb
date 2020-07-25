# frozen_string_literal: true

# Concern module to handle possible exceptions
module ExceptionsHandling
  class Unauthorized < StandardError; end
  extend ActiveSupport::Concern

  included do
    self._serialization_scope = nil
    rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError, with: :unauthorized
  end

  private

  def record_not_found(_)
    render json: { errors: 'Not found' }, status: :not_found
  end

  def unprocessable_entity(exception)
    render json: { errors: [exception.message] }, status: :unprocessable_entity
  end

  def unauthorized(_exception)
    render json: { errors: ['Unauthorized'] }, status: :unauthorized
  end
end
