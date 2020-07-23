# frozen_string_literal: true

describe AdvertSerializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:advert, :with_attached_picture) }

  it { is_expected.to have_attribute :id }
  it { is_expected.to have_attribute :title }
  it { is_expected.to have_attribute :description }
  it { is_expected.to have_attribute :created_at }
  it { is_expected.to have_attribute :updated_at }
  it { is_expected.to have_attribute :picture_url }
  it { is_expected.to have_attribute :thumbnail_url }

  describe '#picture_url' do
    subject(:picture_url) { serializer.picture_url }

    before { allow(serializer).to receive(:rails_blob_path).and_return 'https://rails_blob_path' }

    it { is_expected.to eq 'https://rails_blob_path' }

    it 'uses rails_blob_path method' do
      picture_url

      expect(serializer).to have_received(:rails_blob_path).with(object.picture)
    end
  end

  describe '#thumbnail_url' do
    subject(:thumbnail_url) { serializer.thumbnail_url }

    let(:variant) { double }

    before do
      object.picture.variant(resize: "100x100")
      allow(object.picture).to receive(:variant).with(resize: "100x100").and_return variant
      allow(serializer).to receive(:rails_representation_url).and_return 'https://rails_representation_url'
    end

    it { is_expected.to eq 'https://rails_representation_url' }

    it 'uses rails_representation_url method' do
      thumbnail_url

      expect(serializer).to have_received(:rails_representation_url).with(variant)
    end
  end
end
