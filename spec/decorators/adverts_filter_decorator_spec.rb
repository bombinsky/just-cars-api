# frozen_string_literal: true

describe AdvertsFilterDecorator do
  subject(:decorator) { described_class.new(object) }

  let(:object) { build :adverts_filter }

  describe '#min_price' do
    subject(:min_price) { decorator.min_price }

    it { is_expected.to be_a BigDecimal }
    it { is_expected.to eq object.min_price.to_d }
  end

  describe '#max_price' do
    subject(:max_price) { decorator.max_price }

    it { is_expected.to be_a BigDecimal }
    it { is_expected.to eq object.max_price.to_d }
  end

  describe '#min_created_at' do
    subject(:min_created_at) { decorator.min_created_at }

    it { is_expected.to be_a Date }
    it { is_expected.to eq Date.parse(object.min_created_at) }
  end

  describe '#max_created_at' do
    subject(:max_created_at) { decorator.max_created_at }

    it { is_expected.to be_a Date }
    it { is_expected.to eq Date.parse(object.max_created_at) }
  end
end
