# frozen_string_literal: true

shared_examples 'advert on list serializer' do
  it { is_expected.to have_attribute :id }
  it { is_expected.to have_attribute :title }
  it { is_expected.to have_attribute :created_at }
  it { is_expected.to have_attribute :price }
  it { is_expected.to have_attribute :picture_url }

  describe '#picture_url' do
    subject(:picture_url) { serializer.picture_url }

    before { allow(serializer).to receive(:rails_blob_url).and_return 'https://rails_blob_path' }

    it { is_expected.to eq 'https://rails_blob_path' }

    it 'uses rails_blob_path method' do
      picture_url

      expect(serializer).to have_received(:rails_blob_url).with(object.picture)
    end
  end
end
