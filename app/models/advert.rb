# frozen_string_literal: true

# Class represents advert
class Advert < ApplicationRecord
  PRICE_FORMAT = /\A\d+(?:\.\d{0,2})?\z/.freeze

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { minimum: 64 }
  validates :price, presence: true,
                    numericality: { greater_than: 0, less_than: 10_000_000 },
                    format: { with: PRICE_FORMAT }

  validates :picture, presence: true

  has_one_attached :picture
end
