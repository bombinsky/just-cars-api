# frozen_string_literal: true

# Class represents an authenticated  user of the system
class User < ApplicationRecord
  validates :email, presence: true
  validates :nickname, presence: true
end
