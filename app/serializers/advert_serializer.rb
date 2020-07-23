# frozen_string_literal: true

# Serializer for advert details
class AdvertSerializer < AdvertOnListSerializer
  include Rails.application.routes.url_helpers

  attributes :description, :updated_at, :picture_url

  def picture_url
    rails_blob_path(object.picture)
  end
end
