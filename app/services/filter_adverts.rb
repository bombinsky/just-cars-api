# frozen_string_literal: true

# Service object responsible for adverts filtering
class FilterAdverts
  def initialize(filter)
    @decorated_filter = AdvertsFilterDecorator.new(filter)
  end

  def call
    Advert.search(search_phrase, where: conditions, page: page, per_page: per_page, order: order_hash, includes: includes)
  end

  private

  delegate :phrase, :min_price, :max_price, :min_created_at, :max_created_at, :page, :per_page, :order, to: :decorated_filter

  attr_reader :decorated_filter

  def includes
    { picture_attachment: :blob }
  end

  def search_phrase
    phrase || '*'
  end

  def conditions
    {
      price: { gte: min_price, lte: max_price }.compact,
      created_at: { gte: min_created_at, lte: max_created_at }.compact
    }.delete_if { |_, v| v.blank? }
  end

  def order_hash
    { order_partitions.first.to_sym => order_partitions.last.to_sym }
  end

  def order_partitions
    @order_partitions ||= order.rpartition('_')
  end
end
