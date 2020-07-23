# frozen_string_literal: true

# Service object responsible for advert creation
class CreateAdvert
  def initialize(attributes:)
    @attributes = attributes
  end

  def call
    advert.save! if advert.valid?

    advert
  end

  private

  attr_reader :attributes

  def advert
    @advert ||= Advert.new(attributes)
  end
end