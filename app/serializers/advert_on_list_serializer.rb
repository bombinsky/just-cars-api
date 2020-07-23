# frozen_string_literal: true

# Serializer for advert on list
class AdvertOnListSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :created_at, :thumbnail_url

  def thumbnail_url
    rails_representation_url(object.picture.variant(resize: '100x100'))
  end
end
