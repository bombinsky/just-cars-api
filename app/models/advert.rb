# frozen_string_literal: true

# Class represents advert
class Advert < ApplicationRecord
  PRICE_FORMAT = /\A\d+(?:\.\d{0,2})?\z/.freeze
  ELASTIC_SEARCH_MAPPINGS = { properties: { price: { type: 'double' }, created_at: { type: 'date' } } }.freeze

  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { minimum: 64 }
  validates :price, presence: true,
                    numericality: { greater_than: 0, less_than: 10_000_000 },
                    format: { with: PRICE_FORMAT }

  validates :picture, attached: true, content_type: ['image/png', 'image/jpeg', 'image/gif']

  has_one_attached :picture

  searchkick merge_mappings: true, mappings: ELASTIC_SEARCH_MAPPINGS

  def search_data
    {
      title: title,
      description: description,
      price: price,
      created_at: created_at,
      user_nickname: user.nickname
    }
  end
end
