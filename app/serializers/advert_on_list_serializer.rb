# frozen_string_literal: true

# Serializer for advert on list
class AdvertOnListSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :created_at, :price, :thumbnail_url

  def thumbnail_url
    rails_representation_url(object.picture.variant(resize: Advert::THUMBNAIL_SIZES).processed)
  end
end
