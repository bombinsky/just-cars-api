# frozen_string_literal: true

# Class represents decorator for adverts filter
# it is responsible for deliver proper types to filtering logic
class AdvertsFilterDecorator < Draper::Decorator
  delegate :page, :per_page, :phrase, :order

  def max_price
    object.max_price.to_d if object.max_price
  end

  def min_price
    object.min_price.to_d if object.min_price
  end

  def max_created_at
    Date.parse(object.max_created_at) if object.max_created_at
  end

  def min_created_at
    Date.parse(object.min_created_at) if object.min_created_at
  end
end
