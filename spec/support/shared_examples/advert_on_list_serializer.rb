# frozen_string_literal: true

shared_examples 'advert on list serializer' do
  it { is_expected.to have_attribute :id }
  it { is_expected.to have_attribute :title }
  it { is_expected.to have_attribute :created_at }
  it { is_expected.to have_attribute :thumbnail_url }

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