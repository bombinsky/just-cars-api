# frozen_string_literal: true

(1..30).step do |number|
  email = "email-#{number}@no-domain.com"
  User.find_by(email: email) || User.create!(email: email, nickname: Faker::Internet.username)
end

records_qty = 500

puts "\nLoading #{records_qty} of adverts in seeds. Please wait. This can take a while because of attaching pictures."

Searchkick.disable_callbacks

(1..records_qty).step do |number|
  advert = Advert.new(
    title: [Faker::Vehicle.color, Faker::Vehicle.make_and_model, Faker::Vehicle.engine].join(' '),
    description: Faker::Vehicle.standard_specs.join(' '),
    price: Faker::Commerce.price(range: (50_000..1_000_000.00)),
    created_at: Time.current - number.days,
    user: User.all.sample
  )

  file_name = "car_#{rand(1..10)}.jpg"
  path_to_file = Rails.root.join('spec', 'fixtures', 'files', file_name)
  advert.picture.attach(io: File.open(path_to_file), filename: file_name, content_type: 'image/jpeg')
  advert.save!

  print '.'
  print " #{number} adverts loaded\n" if (number % 100).zero?
end

Searchkick.enable_callbacks

puts "\nReindexing elasticsearch index that will be faster"
Advert.reindex
puts "\nDone\n\n"
