# frozen_string_literal: true

# Custom Validator for ISO 8601 date format
class IsoDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Date.parse(value)
  rescue ArgumentError
    record.errors.add(attribute, 'date should be a string in ISO 8601 format')
  end
end
