# frozen_string_literal: true

namespace :generate_token do
  desc 'generates token for an existing user'
  task :for_existing_user, [:user_email] => :environment do |_, args|
    user = User.find_by!(email: args.user_email)
    payload = { email: user.email, nickname: user.nickname, iat: Time.now.to_i, exp: (Time.now + 1.hour).to_i }
    puts JWT.encode payload, Rails.application.credentials.hmac_secret, DecodeToken::ALGORITHM
  end
end
