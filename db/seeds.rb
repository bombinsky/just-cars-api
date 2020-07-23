# frozen_string_literal: true

include ActionDispatch::TestProcess

price_range = (50_000..1_000_000.00)
records_number = 500

puts "\nLoading #{records_number} of adverts in seeds. Please wait. This can take some time."

(1..records_number).step do |number|
  Advert.create!(
    title: [Faker::Vehicle.color, Faker::Vehicle.make_and_model, Faker::Vehicle.engine].join(' '),
    description: Faker::Vehicle.standard_specs.join(' '),
    price: Faker::Commerce.price(range: price_range),
    picture: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', "car_#{rand(1..10)}.jpg"), 'image/jpeg')
  )
  print '.'
  print " #{number} adverts loaded\n" if (number % 100).zero?
end

print "\n"
