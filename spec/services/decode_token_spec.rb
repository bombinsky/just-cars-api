# frozen_string_literal: true

describe DecodeToken do
  include UserAuthenticationHelper

  describe '#call' do
    subject(:service_call) { described_class.new(id_token(user)).call }

    context 'when user already exists' do
      let(:user) { create :user }

      it { is_expected.to eq user }
    end

    context 'when user does not exist' do
      let(:user) { build :user }

      it { is_expected.to be_an User }

      it 'creates new user' do
        expect { service_call }.to change(User, :count)
      end
    end
  end
end
