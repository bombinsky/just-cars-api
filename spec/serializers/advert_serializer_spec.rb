# frozen_string_literal: true

describe AdvertSerializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:advert, :with_attached_picture) }

  it_behaves_like 'advert on list serializer'

  it { is_expected.to have_attribute :description }
  it { is_expected.to have_attribute :updated_at }
  it { is_expected.to have_association :user }
  it { is_expected.to have_attribute :picture_url }

  describe '#picture_url' do
    subject(:picture_url) { serializer.picture_url }

    before { allow(serializer).to receive(:rails_blob_url).and_return 'https://rails_blob_url' }

    it { is_expected.to eq 'https://rails_blob_url' }

    it 'uses rails_blob_path method' do
      picture_url

      expect(serializer).to have_received(:rails_blob_url).with(object.picture)
    end
  end
end
