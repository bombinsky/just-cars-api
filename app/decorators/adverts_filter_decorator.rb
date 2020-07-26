# frozen_string_literal: true

# Class represents decorator for adverts filter
# it is responsible for deliver proper types to filtering logic
class AdvertsFilterDecorator < Draper::Decorator
  delegate :phrase, :order

  def page
    to_integer(object.page)
  end

  def per_page
    to_integer(object.per_page)
  end

  def max_price
    to_decimal(object.max_price)
  end

  def min_price
    to_decimal(object.min_price)
  end

  def max_created_at
    to_date(object.max_created_at)
  end

  def min_created_at
    to_date(object.min_created_at)
  end

  private

  def to_decimal(value)
    value.to_d if value
  end

  def to_integer(value)
    value.to_i if value
  end

  def to_date(value)
    Date.parse(value) if value
  end
end
