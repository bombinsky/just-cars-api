# frozen_string_literal: true

describe FilterAdverts do
  describe '#call' do
    subject(:service_call) { described_class.new(filter).call }

    let(:decorated_filter) { AdvertsFilterDecorator.new(filter) }
    let(:filtered_adverts) { build_list :advert, 3 }

    let(:expected_phrase) { '*' }
    let(:expected_conditions) { {} }
    let(:expected_page) { 1 }
    let(:expected_per_page) { 20 }
    let(:expected_order_hash) { { _score: :desc } }
    let(:expected_includes) { { picture_attachment: :blob } }
    let(:expected_search_params) do
      [
        expected_phrase,
        {
          where: expected_conditions,
          page: expected_page,
          per_page: expected_per_page,
          order: expected_order_hash,
          includes: expected_includes
        }
      ]
    end

    before do
      allow(Advert).to receive(:search).and_return filtered_adverts

      service_call
    end

    shared_examples 'searching with proper parameters' do
      it 'searches adverts in search kick with proper attributes' do
        expect(Advert).to have_received(:search).with(*expected_search_params)
      end
    end

    shared_examples 'sorting with proper order' do |order_type, expected_order_hash|
      context "when #{order_type} order provided" do
        let(:filter) { AdvertsFilter.new(order: order_type) }
        let(:expected_order_hash) { expected_order_hash }

        it_behaves_like 'searching with proper parameters'
      end
    end

    context 'when filter is blank' do
      let(:filter) { AdvertsFilter.new }

      it_behaves_like 'searching with proper parameters'
    end

    context 'when phrase provided' do
      let(:filter) { AdvertsFilter.new(phrase: 'searched phrase') }
      let(:expected_phrase) { 'searched phrase' }

      it_behaves_like 'searching with proper parameters'
    end

    context 'when max_price provided' do
      let(:filter) { AdvertsFilter.new(max_price: '100.05') }
      let(:expected_conditions) { { price: { lte: 100.05 } } }

      it_behaves_like 'searching with proper parameters'
    end

    context 'when min_price provided' do
      let(:filter) { AdvertsFilter.new(min_price: '100.15') }
      let(:expected_conditions) { { price: { gte: 100.15 } } }

      it_behaves_like 'searching with proper parameters'
    end

    context 'when max_created_at provided' do
      let(:filter) { AdvertsFilter.new(max_created_at: '2020-01-11') }
      let(:expected_conditions) { { created_at: { lte: Date.parse('2020-01-11') } } }

      it_behaves_like 'searching with proper parameters'
    end

    context 'when min_created_at provided' do
      let(:filter) { AdvertsFilter.new(min_created_at: '2020-01-01') }
      let(:expected_conditions) { { created_at: { gte: Date.parse('2020-01-01') } } }

      it_behaves_like 'searching with proper parameters'
    end

    context 'when page provided' do
      let(:filter) { AdvertsFilter.new(page: '2') }
      let(:expected_page) { 2 }

      it_behaves_like 'searching with proper parameters'
    end

    context 'when per_page provided' do
      let(:filter) { AdvertsFilter.new(per_page: '30') }
      let(:expected_per_page) { 30 }

      it_behaves_like 'searching with proper parameters'
    end

    it_behaves_like 'sorting with proper order', 'created_at_desc', { created_at: :desc }
    it_behaves_like 'sorting with proper order', 'created_at_asc', { created_at: :asc }
    it_behaves_like 'sorting with proper order', 'price_desc', { price: :desc }
    it_behaves_like 'sorting with proper order', 'price_asc', { price: :asc }
    it_behaves_like 'sorting with proper order', 'title_desc', { title: :desc }
    it_behaves_like 'sorting with proper order', 'title_asc', { title: :asc }
    it_behaves_like 'sorting with proper order', '_score_desc', { _score: :desc }
  end
end
