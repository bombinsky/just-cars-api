# frozen_string_literal: true

# Serializer for advert details
class AdvertSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :created_at, :updated_at, :picture_url, :thumbnail_url

  def picture_url
    rails_blob_path(object.picture)
  end

  def thumbnail_url
    rails_representation_url(object.picture.variant(resize: "100x100"))
  end
end