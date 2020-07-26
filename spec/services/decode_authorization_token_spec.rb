# frozen_string_literal: true

describe DecodeAuthorizationToken do
  include AuhorizationAndAuthenticationHelper

  describe '#call' do
    subject(:service_call) { described_class.new(authorization_token).call }

    it 'does not raise errors' do
      expect { service_call }.not_to raise_error
    end
  end
end
