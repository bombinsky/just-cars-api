# frozen_string_literal: true

# Class represents adverts filter
class AdvertsFilter
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Serialization

  ALLOWED_ORDERS = %w[created_at_desc created_at_asc price_desc price_asc title_asc title_desc _score_desc]
  ATTRIBUTES = %i[page per_page min_price max_price min_created_at max_created_at phrase order]

  attr_accessor(*ATTRIBUTES)

  validates :phrase, length: { minimum: 3 }, if: :phrase
  validates :page, numericality: { greater_than: 0, only_integer: true, allow_nil: true }
  validates :per_page, numericality: { greater_than: 0, only_integer: true, allow_nil: true }
  validates :min_price, numericality: { greater_than: 0 }, format: { with: Advert::PRICE_FORMAT }, if: :min_price
  validates :max_price, numericality: { greater_than: 0 }, format: { with: Advert::PRICE_FORMAT }, if: :max_price
  validates :min_created_at, iso_date: true, if: :min_created_at
  validates :max_created_at, iso_date: true, if: :max_created_at
  validates :order, inclusion: { in: ALLOWED_ORDERS }, if: :order

  def initialize(attributes = {})
    super
    @page = attributes[:page] || 1
    @per_page = attributes[:per_page] || 20
    @order = attributes[:order] || '_score_desc'
  end
end
