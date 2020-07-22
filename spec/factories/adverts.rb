# frozen_string_literal: true

FactoryBot.define do
  factory :advert do
    title { 'MyString' }
    description { 'MyText' }
    price { '9.99' }
  end
end
