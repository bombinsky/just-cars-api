# frozen_string_literal: true

namespace :generate do
  desc 'generates authentication token for an existing user'
  task :authentication_token, [:user_email] => :environment do |_, args|
    user = User.find_by(email: args.user_email) || User.create(email: args.user_email, nickname: 'nickname')
    payload = { email: user.email, nickname: user.nickname, iat: Time.now.to_i, exp: (Time.now + 1.hour).to_i }
    puts JWT.encode payload, Rails.application.credentials.hmac_secret, DecodeAuthenticationToken::ALGORITHM
  end

  desc 'generates authorization token for api access'
  task authorization_token: :environment do
    payload = { iat: Time.now.to_i, exp: (Time.now + 1.hour).to_i }
    puts JWT.encode(payload, Rails.application.credentials.hmac_secret, DecodeAuthorizationToken::ALGORITHM)
  end
end
