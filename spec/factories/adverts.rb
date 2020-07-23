# frozen_string_literal: true

FactoryBot.define do
  factory :advert do
    title { 'MyString' }
    description { 'Lorem ipsum ' * 6  }
    price { '9.99' }
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'ruby.jpg'), 'image/jpeg') }

    trait :with_attached_picture do
      after(:create) do |advert|
        advert.picture.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'ruby.jpg')),
                              filename: 'ruby.jpg', content_type: 'image/jpeg')
      end
    end
  end
end
