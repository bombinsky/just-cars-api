# frozen_string_literal: true

describe AdvertSerializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:advert, :with_attached_picture) }

  it_behaves_like 'advert on list serializer'

  it { is_expected.to have_attribute :description }
  it { is_expected.to have_attribute :updated_at }
end
