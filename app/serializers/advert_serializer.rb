# frozen_string_literal: true

# Serializer for advert details
class AdvertSerializer < AdvertOnListSerializer
  attributes :description, :updated_at

  has_one :user
end
