# frozen_string_literal: true

FactoryBot.define do
  factory :adverts_filter do
    page { '5' }
    per_page { '20' }
    min_price { '50000.00' }
    max_price { '100000.00' }
    min_created_at { '2020-01-01' }
    max_created_at { '2020-08-01' }
    phrase { 'audi' }
    order { 'created_ad_desc' }
  end
end
