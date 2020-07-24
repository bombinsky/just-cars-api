# frozen_string_literal: true

describe UserSerializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { build(:user) }

  it { is_expected.to have_attribute :email }
  it { is_expected.to have_attribute :nickname }
end
