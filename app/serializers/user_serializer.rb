# frozen_string_literal: true

# Serializer for user serialization
class UserSerializer < ActiveModel::Serializer
  attributes :email, :nickname
end
