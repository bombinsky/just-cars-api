# frozen_string_literal: true

# Serializer for advert on list
class AdvertOnListSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :created_at, :price, :picture_url

  def picture_url
    rails_blob_url(object.picture)
  end
end
