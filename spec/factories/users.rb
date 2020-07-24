FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "email-#{ i }@not_existing.domain.com" }
    nickname { "nickname" }
  end
end
