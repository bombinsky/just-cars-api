# frozen_string_literal: true

describe AdvertOnListSerializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:advert, :with_attached_picture) }

  it_behaves_like 'advert on list serializer'
end
