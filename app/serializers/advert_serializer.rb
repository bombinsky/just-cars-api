# frozen_string_literal: true

# Serializer for advert details
class AdvertSerializer < AdvertOnListSerializer
  attributes :description, :updated_at, :picture_url

  has_one :user

  def picture_url
    rails_blob_url(object.picture)
  end
end
