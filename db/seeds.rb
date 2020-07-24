# frozen_string_literal: true

include ActionDispatch::TestProcess

(1..30).step do |number|
  User.create!(email: "email-#{number}@no-domain.com", nickname: Faker::Internet.username)
end

price_range = (50_000..1_000_000.00)
records_qty = 500

puts "\nLoading #{records_qty} of adverts in seeds. Please wait. This can take a while because of attaching pictures."

(1..records_qty).step do |number|
  Advert.create!(
    title: [Faker::Vehicle.color, Faker::Vehicle.make_and_model, Faker::Vehicle.engine].join(' '),
    description: Faker::Vehicle.standard_specs.join(' '),
    price: Faker::Commerce.price(range: price_range),
    picture: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', "car_#{rand(1..10)}.jpg"), 'image/jpeg'),
    created_at: Time.current - number.days,
    user: User.all.sample
  )
  print '.'
  print " #{number} adverts loaded\n" if (number % 100).zero?
end

puts "\nReindexing elasticsearch index that will be faster"
Advert.reindex
puts "\nDone\n\n"
