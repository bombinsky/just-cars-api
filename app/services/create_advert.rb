# frozen_string_literal: true

# Service object responsible for advert creation
class CreateAdvert
  def initialize(user:, attributes:)
    @user = user
    @attributes = attributes
  end

  def call
    advert.save! if advert.valid?

    advert
  end

  private

  attr_reader :user, :attributes

  def advert
    @advert ||= Advert.new(attributes.merge(user: user))
  end
end
